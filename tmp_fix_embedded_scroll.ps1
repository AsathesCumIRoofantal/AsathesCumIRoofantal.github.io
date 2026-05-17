$names = @(
    'AboutAppView','AboutOrgView','AdvantageView','AffectionLoveView','AirVisionView','AppreciationsThanksView','CategoryDocsView','CategoryTreeView','ChallengeView','CodeConductView','CommerceView','CompititionView','ControlCoordinationView','CountingReportsView','CourtCasesView','DemonstrationView','DigitalizeRecordsView','DiscoveryView','DoctorateView','EaseToolsView','ElectionsView','EmpathySympathyView','EngagementsView','EnhancementView','EntitiesView','FamilyView','FeedbackView','FingersAreCrossedView','ForgivnessView','FriendshipView','GroundTaskView','GroupDiscussionsView','HeartWinningView','HeigherStudiesView','HopeView','HospitalityCareView','IdentitiesEarningsView','IdentityView','InnovationView','InterviewsView','JoiningServicesView','KeepAddingWithPatienceView','KindnessView','KnowledgeCenterView','LanguageTranslationView','LeadershipView','LearnFunView','LifeHacksView','LoginView','LoopHoleView','LoyaltyView','MarketingPromotionView','MediaNewsView','MedicalView','MeritsDemeritsView','MonitorshipView','ObligationsView','OnlyOneWayView','PeaceProsperityView','PrayerForAllView','ProductsServicesView','ProjectsAssessmentsView','PunctualityView','QueriesView','QueryDiscussionView','RankingOrdersView','RecordPostView','RelationshipsView','ReligionPrayerView','ResearchDevelopmentView','RespectView','ResponsibilitiesView','RivalryView','RulesRegulationsView','SafetyView','ScriptStrategyView','SelfDisciplineView','ServeView','SettingsView','ShareExperienceView','SignupView','SituationReactionView','SocialView','SolutionView','SpiritualityLordShivaView','StatisticsView','SuccessFailureView','SurvellenceInvestigationView','TechnologyView','TradeImportExportView','TravelTransportView','UnionsView','UniversalPeaceRuleView','UtilitiesGuestView','UtilityFacilitiesView','VocabularyView','WisdomView','WorldView'
)

$viewFiles = @()
foreach ($name in $names) {
    $match = Select-String -Path 'lib/modules/**/*.dart' -Pattern "class $name" -SimpleMatch | Select-Object -First 1
    if ($match) { $viewFiles += $match.Path }
}
$viewFiles = $viewFiles | Sort-Object -Unique

function AddEmbeddedSupport($path) {
    $text = Get-Content -Raw -Path $path
    $classMatch = [regex]::Match($text, 'class\s+([A-Za-z0-9_]+View)\s+extends\s+[^{]+\{')
    if (-not $classMatch.Success) { return }
    $className = $classMatch.Groups[1].Value
    if ($text -notmatch 'final bool isEmbedded;') {
        $text = [regex]::Replace($text, '(class\s+' + [regex]::Escape($className) + '\s+extends\s+[^{]+\{)', '$1\n  final bool isEmbedded;')
    }
    if ($text -match ('const\s+' + [regex]::Escape($className) + '\(\{super\.key\}\);')) {
        $text = [regex]::Replace($text, 'const\s+' + [regex]::Escape($className) + '\(\{super\.key\}\);', 'const ' + $className + '({super.key, this.isEmbedded = false});')
    }
    elseif ($text -notmatch ('const\s+' + [regex]::Escape($className) + '\(')) {
        $text = [regex]::Replace($text, '(class\s+' + [regex]::Escape($className) + '\s+extends\s+[^{]+\{)', '$1\n  const ' + $className + '({super.key, this.isEmbedded = false});')
    }
    $replacements = @(
        @('body:\s+ListView\(', 'body: ListView(\n        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,\n        shrinkWrap: isEmbedded,'),
        @('child:\s+ListView\(', 'child: ListView(\n        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,\n        shrinkWrap: isEmbedded,'),
        @('return\s+ListView\(', 'return ListView(\n        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,\n        shrinkWrap: isEmbedded,'),
        @('body:\s+SingleChildScrollView\(', 'body: SingleChildScrollView(\n        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,'),
        @('child:\s+SingleChildScrollView\(', 'child: SingleChildScrollView(\n        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,'),
        @('return\s+SingleChildScrollView\(', 'return SingleChildScrollView(\n        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,'),
        @('CustomScrollView\(', 'CustomScrollView(\n        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,\n        shrinkWrap: isEmbedded,'),
        @('GridView\.count\(', 'GridView.count(\n        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,\n        shrinkWrap: isEmbedded,'),
        @('GridView\.builder\(', 'GridView.builder(\n        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,\n        shrinkWrap: isEmbedded,'),
        @('GridView\(', 'GridView(\n        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,\n        shrinkWrap: isEmbedded,')
    )
    foreach ($pair in $replacements) {
        $text = [regex]::Replace($text, $pair[0], $pair[1])
    }
    $text = [regex]::Replace($text, '(physics:\s*isEmbedded\s*\?\s*const\s*NeverScrollableScrollPhysics\(\)\s*:\s*null,\s*shrinkWrap:\s*isEmbedded,\s*){2,}', '$1')
    Set-Content -Path $path -Value $text
    Write-Host "Updated view file: $path"
}

foreach ($path in $viewFiles) { AddEmbeddedSupport $path }

# Patch wrapper SliverToBoxAdapter usages.
foreach ($name in $names) {
    $pattern = 'SliverToBoxAdapter\(child:\s*const\s+' + [regex]::Escape($name) + '\(\)\)'
    $files = Select-String -Path 'lib/modules/**/*.dart' -Pattern $pattern | Select-Object -Unique Path
    foreach ($file in $files) {
        $text = Get-Content -Raw -Path $file
        $text = [regex]::Replace($text, [regex]::Escape('SliverToBoxAdapter(child: const ' + $name + '())'), 'SliverToBoxAdapter(child: const ' + $name + '(isEmbedded: true))')
        Set-Content -Path $file -Value $text
        Write-Host "Patched wrapper: $file"
    }
}

Write-Host 'Patch script completed.'
