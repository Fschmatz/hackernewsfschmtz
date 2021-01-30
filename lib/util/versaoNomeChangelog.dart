class versaoNomeChangelog{

  //se mudar o nome do App não esquecer de alterar, no manifesto
  static String versaoApp = "2.8";
  static String nomeApp = "HackerNews Fschmtz";

  //1espaço acima, nenhum embaixo
  static String changelogUltimaVersao = '''  
  
Versão Atual:  

2.8
- Mark as Read
- Database (only 40 rows)
''';

  static String changelogsAntigos = '''

2.7
- Fixes

2.6
- App in English
- Added TimeAgo
- Fixes

2.5
- Score and Number of Comments on Home
- Fixes

2.4
- Skip
- Fixes

2.3b
- Fixes
- Ask HN now opens the Comments

2.2b
- Hide AppBar
- Fixes

2.1
- StatelessWidget for Story
- Removed BouncePhysics

2.0
- LazyLoadScrollView implemented
- Removed ScrollListener
  (Note: Flutter has performance problems,
  with ScrollListener in Listview.builder / separated
  and use of Physics)
  
1.9
- Fixed BottomLoading animation
- Bouncing Physics

1.8
- Timer Secondary getTopStories
- Fixes

1.7b
- Implemented Secondary getTopStories 
- Removed TapDown

1.7
- Bottom ProgressBar for Scroll

1.6
- Home classes separated
- Refresh Dialog Loading
- Removed Gesture Detector for Performance

1.5b
- Fixed Null link error

1.5
- SkeletonAnimation
- Fixes

1.4
- Fixes
- AnimatedSwitcher

1.3
- TopBar Hide / Unhide
- Fixes
- New Icon

1.2
- Layout Changes
- Card Removed
- Fixes
  
1.1
- ScrollController
- Fixes

1.0
- Fixes

0.9b
- Fixes
- Card changes

0.8
- Fixes
- Chrome Custom Tabs

0.7
- Fixes
- Tests with LazyLoading

0.6
- Open links in the browser

0.5
- New Card
- Flutter Share

0.4
- Fixes

0.3
- Fixes
- Add Internet to the manifest

0.2
- Fixes

0.1
- Project Start                                  

''';

}