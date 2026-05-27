import SwiftUI
import SwiftData

struct MealsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \MealEntry.timestamp, order: .reverse) private var meals: [MealEntry]
    @State private var viewModel = MealLogViewModel()
    @State private var selectedDate: Date = .now.startOfDay

    // MARK: - Computed

    private var displayDateLabel: String {
        if Calendar.current.isDateInToday(selectedDate) { return "Today" }
        if Calendar.current.isDateInYesterday(selectedDate) { return "Yesterday" }
        let fmt = DateFormatter()
        fmt.dateFormat = "MMMM d"
        return fmt.string(from: selectedDate)
    }

    private var mealsForDate: [MealEntry] {
        meals.filter { Calendar.current.isDate($0.timestamp, inSameDayAs: selectedDate) }
    }

    private var groupedMeals: [(MealType, [MealEntry])] {
        let order: [MealType] = [.breakfast, .lunch, .dinner, .snack]
        return order.compactMap { type in
            let filtered = mealsForDate.filter { $0.mealType == type }
            return filtered.isEmpty ? nil : (type, filtered)
        }
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            // Date navigation bar
            datePicker

            if mealsForDate.isEmpty {
                Spacer()
                FGEmptyState(
                    icon: "fork.knife",
                    title: Calendar.current.isDateInToday(selectedDate) ? "No meals today" : "No meals logged",
                    message: Calendar.current.isDateInToday(selectedDate)
                        ? "Tap the + button to log your first meal."
                        : "Nothing was logged for this day.",
                    actionTitle: Calendar.current.isDateInToday(selectedDate) ? "Log a Meal" : nil,
                    action: Calendar.current.isDateInToday(selectedDate) ? { viewModel.showingLogSheet = true } : nil
                )
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: FGSpacing.lg) {
                        // Grouped sections
                        ForEach(groupedMeals, id: \.0) { type, entries in
                            MealSection(mealType: type, entries: entries, viewModel: viewModel)
                        }

                        // Encouragement banner
                        if !mealsForDate.isEmpty {
                            encouragementBanner
                                .padding(.horizontal, FGSpacing.screenPadding)
                        }
                    }
                    .padding(.top, FGSpacing.md)
                    .padding(.bottom, FGSpacing.xxl)
                }
            }
        }
        .background(FGColors.background)
        .navigationTitle("Meals")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button { viewModel.showingLogSheet = true } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(FGColors.accent)
                }
                .accessibilityLabel("Log a meal")
            }
        }
        .sheet(isPresented: $viewModel.showingLogSheet) {
            LogMealSheet()
        }
    }

    // MARK: - Sub-views

    private var datePicker: some View {
        HStack(spacing: FGSpacing.lg) {
            Button {
                withAnimation(FGAnimations.gentle) {
                    selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(FGColors.accent)
                    .frame(width: 44, height: 44)
            }
            .accessibilityLabel("Previous day")

            Spacer()

            VStack(spacing: 2) {
                Text(displayDateLabel)
                    .font(FGTypography.headline)
                    .foregroundStyle(FGColors.textPrimary)
                Text(selectedDate, format: .dateTime.month(.wide).day().year())
                    .font(FGTypography.caption)
                    .foregroundStyle(FGColors.textSecondary)
            }

            Spacer()

            Button {
                withAnimation(FGAnimations.gentle) {
                    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
                    // Don't go into the future
                    if tomorrow <= Date.now.startOfDay {
                        selectedDate = tomorrow
                    }
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Calendar.current.isDateInToday(selectedDate) ? FGColors.textSecondary.opacity(0.3) : FGColors.accent)
                    .frame(width: 44, height: 44)
            }
            .disabled(Calendar.current.isDateInToday(selectedDate))
            .accessibilityLabel("Next day")
        }
        .padding(.horizontal, FGSpacing.screenPadding)
        .padding(.vertical, FGSpacing.sm)
        .background(FGColors.surface)
    }

    private var encouragementBanner: some View {
        let count = mealsForDate.count
        let message = count >= 3
            ? "Well done! You've logged \(count) meals today. 🌟"
            : "You've logged \(count) meal\(count == 1 ? "" : "s") — keep going!"

        return HStack(spacing: FGSpacing.sm) {
            Image(systemName: count >= 3 ? "star.fill" : "heart.fill")
                .foregroundStyle(.white)
            Text(message)
                .font(FGTypography.bodyBold)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, FGSpacing.lg)
        .padding(.vertical, FGSpacing.md)
        .frame(maxWidth: .infinity)
        .background(count >= 3 ? Color.green : FGColors.accent)
        .clipShape(RoundedRectangle(cornerRadius: FGSpacing.cardRadius))
    }
}

// MARK: - MealSection

private struct MealSection: View {
    let mealType: MealType
    let entries: [MealEntry]
    let viewModel: MealLogViewModel
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack(alignment: .leading, spacing: FGSpacing.sm) {
            // Section header
            HStack(spacing: FGSpacing.sm) {
                Image(systemName: mealType.iconName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color(hex: "#4A7C59"))
                Text(mealType.displayName)
                    .font(FGTypography.bodyBold)
                    .foregroundStyle(Color(hex: "#4A7C59"))
            }
            .padding(.horizontal, FGSpacing.screenPadding)

            // Rows
            VStack(spacing: 0) {
                ForEach(entries) { meal in
                    NavigationLink(destination: MealDetailView(meal: meal)) {
                        MealLogRow(meal: meal)
                            .padding(.horizontal, FGSpacing.screenPadding)
                    }
                    .buttonStyle(.plain)
                    .background(FGColors.surface)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.deleteMeal(meal, context: modelContext)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            viewModel.toggleFavorite(meal)
                        } label: {
                            Label(
                                meal.isFavorite ? "Unfavorite" : "Favorite",
                                systemImage: meal.isFavorite ? "heart.slash" : "heart"
                            )
                        }
                        .tint(FGColors.warmOrange)
                    }

                    if meal.id != entries.last?.id {
                        Divider()
                            .padding(.leading, FGSpacing.screenPadding + 48 + FGSpacing.md)
                    }
                }
            }
            .background(FGColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FGSpacing.cardRadius))
            .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
            .padding(.horizontal, FGSpacing.screenPadding)
        }
    }
}
