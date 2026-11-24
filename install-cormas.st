"Load the Core of Cormas, without its user interface, at the version given by CORMAS_VERSION: a branch, a tag or a commit of github.com/cormas/cormas"

Metacello new
  baseline: 'Cormas';
  repository: 'github://cormas/cormas:' , (Smalltalk os environment at: 'CORMAS_VERSION');
  load: #Core.

Smalltalk snapshot: true andQuit: true.
