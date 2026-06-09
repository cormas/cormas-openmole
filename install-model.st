| config |

config := STONJSON fromString: 'config.json' asFileReference contents.

Metacello new
  baseline: (config at: 'baselineName');
  repository:
    'github://',
    (config at: 'repositoryOwner'),
    '/',
    (config at: 'repositoryName'),
    ':',
    (config at: 'version');
  load.

Smalltalk snapshot: true andQuit: true.