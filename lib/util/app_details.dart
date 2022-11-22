class AppDetails{

  static String appVersion = "4.3.3";
  static String appName = "Hacker News Fschmatz";
  static String repositoryLink = 'https://github.com/Fschmatz/hackernewsfschmtz';

  static String changelogCurrent = '''
4.3.3
- Get State Management
- Bug fixes
- Small UI changes
- Removed Get from article list (conflicts with lazy load)
''';

  static String changelogsOld = '''
4.2.11
- API changes
- Hold to share
- Bug fixes
- Added system theme
- Flutter 3

4.1.7
- Material You navbar
- Hide navbar
- Dart lints
- Null safety
- Snackbar with retry

4.0.0
- Hide appbar
- Added navbar
- Changed internal logic
- Small fixes

3.5.0
- Swipe down to refresh
- Hold comments button to share the url of the comments page
- Small UI changes

3.4.2
- Small fixes
- Stack on home

3.3.5
- Small UI changes
- Formatted url
- New settings page

3.3.0
- Hoping the problem with duplicate stories has been dealt
- Removed cards from listview
    
3.2.5
- UI changes
- Small fixes

3.1.1
- Bug fix

3.1.0
- Small UI changes
- Small fixes

3.0.1
- Small changes

3.0.0
- Added new stories page
- Added best stories page
- Added ask hn stories page
- Added show hn stories page
- Small UI changes

2.2.2
- Hotfix

2.2.1
- Changed timers to functions to end cases of double articles
- Small UI changes  

2.1.0
- Removed timers
- Small changes

2.0.0
- Internal logic changes
- Even more UI changes

1.9.1
- More UI changes

1.9.0
- UI changes
- Small fixes

1.8.2
- Fix share bug

1.8.1
- New story card(again!)
- Small fixes

1.8.0
- Added singlechildscrollview (scrolling improvements)
- Small fixes

1.7.1
- Fixes

1.7.0
- Internal logic changes
- Small fixes
- Changed chrome custom tabs for url launcher

1.6.4
- Containerstory separated and organized

1.6.3
- Small fixes

1.6.2
- Small fixes
- Small colors changes read/unread

1.6.1
- Fixes
- Statefulwidget for story

1.6.0
- Mark as read
- Database read (only 40 rows)

1.5.1
- Fixes

1.5.0
- App in english
- Added timeago
- Fixes

1.4.5
- Score on home
- Number of comments on home
- Fixes

1.4.4
- Skip
- Fixes

1.4.3
- Fixes
- Ask hn now opens the comments

1.4.2
- Hide appbar
- Fixes

1.4.1
- Statelesswidget for story
- Removed bouncephysics

1.4.0
- Lazyloadscrollview implemented
- Removed scrolllistener
  (note: flutter has performance problems,
  with scrolllistener in listview.bUIlder / separated
  and use of physics)
  
1.3.4
- Fixed bottomloading animation
- Bouncing physics

1.3.3
- Timer secondary gettopstories
- Fixes

1.3.2
- Implemented secondary gettopstories 
- Removed tapdown

1.3.1
- Bottom progressbar for scroll

1.3.0
- Home classes separated
- Refresh dialog loading
- Removed gesture detector for performance

1.2.1
- Fixed null link error

1.2.0
- Skeleton animation
- Fixes

1.1.1
- Fixes
- Animatedswitcher

1.1.0
- Topbar hide / unhide
- Fixes
- New icon

1.0.0
- Layout changes
- Card removed
- Fixes
  
0.1.1
- Scrollcontroller
- Fixes

0.1.0
- Fixes

0.0.9
- Fixes
- Card changes

0.0.8
- Fixes
- Chrome custom tabs

0.0.7
- Fixes
- Tests with lazyloading

0.0.6
- Open links in the browser

0.0.5
- New card
- Flutter share

0.0.4
- Fixes

0.0.3
- Fixes
- Add internet to the manifest

0.0.2
- Fixes

0.0.1
- Project start                                  

      (ಠ‿ಠ)  
''';

}