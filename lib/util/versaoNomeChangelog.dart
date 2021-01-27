class versaoNomeChangelog{

  //se mudar o nome do App não esquecer de alterar, no manifesto
  static String versaoApp = "2.3b";
  static String nomeApp = "HackerNews Fschmtz";

  //1espaço acima, nenhum embaixo
  static String changelogUltimaVersao = '''  
  
Versão Atual:  

2.3b
- Correções
- Ask HN agora abre os comentários
''';

  static String changelogsAntigos = '''

2.2b
- Hide AppBar
- Correções

2.1
- StatelessWidget para Story
- Removido BouncePhysics

2.0
- LazyLoadScrollView implementado
- Removido ScrollListener 
  (Obs.: Flutter tem problemas de performance,
  com ScrollListener no Listview.builder/separated
  e uso do Physics)
  
1.9
- Corrigida a animação do BottomLoading
- Bouncing Physics

1.8
- Timer getTopStoriesSecundario
- Correções

1.7b
- Implementado getTopStoriesSecundario
- Removido TapDown

1.7
- Bottom ProgressBar para Scroll

1.6
- Separadas as classes da Home
- Dialog Loading do Refresh
- Removido Gesture Detector pela Performance

1.5b
- Corrigido o erro do link Null

1.5
- SkeletonAnimation
- Correções

1.4
- Correções
- AnimatedSwitcher

1.3
- TopBar Hide/Unhide
- Correções
- Novo Ícone

1.2
- Mudanças de Layout
- Card Removido
- Correções
  
1.1
- ScrollController
- Correções

1.0
- Correções

0.9b
- Correções
- Mudanças no Card

0.8
- Correções
- Chrome Custom Tabs

0.7
- Correções
- Testes com LazyLoading

0.6
- Abrir links no browser

0.5
- Novo Card
- Flutter Share

0.4
- Correções

0.3
- Correções
- Add Internet ao manifesto

0.2
- Correções

0.1
- Inicio do Projeto                                   

''';

}