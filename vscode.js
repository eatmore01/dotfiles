{
  "chat.disableAIFeatures": true,
  "workbench.panel.opensMaximized": "always",
  "workbench.iconTheme": "catppuccin-latte",
  "update.mode": "none",
  "extensions.autoUpdate": "off",
  "extensions.ignoreRecommendations": true,
  "security.workspace.trust.untrustedFiles": "open",
  "redhat.telemetry.enabled": false,
  "yaml-with-script.enabled": true,
  "window.zoomLevel": 1,
  "window.title": "x-x ${folderPath}",
  "editor.fontSize": 11.5,
  "editor.fontLigatures": true,
  "editor.minimap.enabled": false,
  "editor.guides.bracketPairs": "active",
  "editor.unicodeHighlight.nonBasicASCII": false,
  "editor.lineNumbers": "on",
  "editor.renderLineHighlight": "all",
  "editor.cursorSurroundingLines": 8,
  "editor.cursorSurroundingLinesStyle": "all",
  "editor.wordWrap": "on",
  "editor.wrappingIndent": "same",
  "editor.folding": false,
  "editor.showFoldingControls": "never",
  "editor.semanticHighlighting.enabled": true,
  "editor.autoIndent": "full",
  "editor.comments.insertSpace": true,
  "editor.comments.ignoreEmptyLines": true,
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "editor.detectIndentation": false,
  "editor.formatOnSave": true,
  // "editor.defaultFormatter": "hashicorp.terraform",
  "editor.quickSuggestionsDelay": 0,
  "files.hotExit": "off",
  "files.associations": {
    "*.tf": "terraform",
    "*.tfvars": "terraform-vars"
  },
  "files.exclude": {
    "**/.git": false,
    "**/.svn": false,
    "**/.hg": false,
    "**/CVS": false,
    "**/.DS_Store": false,
    "**/Thumbs.db": false
  },
  "files.watcherExclude": {
    "**/node_modules/**": true,
    "**/.terraform/**": true,
    "**/venv/**": true,
    "**/.venv/**": true,
    "**/dist/**": true,
    "**/build/**": true,
    "**/target/**": true
  },
  "search.useIgnoreFiles": true,
  "search.exclude": {
    "**/node_modules": true,
    "**/.git": true,
    "**/venv": true,
    "**/.venv": true,
    "**/.terraform": true,
    "**/dist": true,
    "**/build": true,
    "**/target": true,
    "**/.idea": true,
    "**/.vscode": true
  },
  "explorer.compactFolders": false,
  "explorer.autoReveal": true,
  "explorer.excludeGitIgnore": false,
  "explorer.confirmDelete": false,
  "explorer.confirmDragAndDrop": false,
  "explorer.confirmPasteNative": false,
  "workbench.editor.showTabs": "multiple",
  "workbench.editor.openSideBySideDirection": "right",
  "workbench.editor.decorations.badges": true,
  "workbench.editor.decorations.colors": true,
  "workbench.editor.tabActionLocation": "right",
  "diffEditor.renderSideBySide": true,
  "git.ignoreMissingGitWarning": true,
  "git.openRepositoryInParentFolders": "always",
  "terminal.integrated.cursorStyle": "line",
  "terminal.integrated.fontSize": 14,
  "terminal.integrated.mouseWheelScrollSensitivity": 3,
  "terminal.integrated.gpuAcceleration": "off",
  "better-yaml.indentSeq": false,
  "better-yaml.lineWidth": 0,
  "better-yaml.flowCollectionPadding": true,
  // yaml
  "yaml.validate": true,
  "yaml.hover": true,
  "yaml.completion": true,
  "yaml.format.enable": false,
  "yaml.kubernetesVersion": "v1.37.0",
  "yaml.kubernetesCRDStore.enable": true,
  "yaml.schemaStore.enable": false,
  "yaml.schemas": {
    "kubernetes": [
      "*.yaml",
      "*.yml"
    ],
    "https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json": [
      ".gitlab-ci.yml"
    ]
  },
  "yaml.disableSchemaDetection": [
    ".github/workflows/*.yml",
    ".github/workflows/*.yaml",
    ".github/actions/**/action.yml",
    ".github/actions/**/action.yaml",
  ],
  "[yaml]": {
    "editor.tabSize": 2,
    "editor.insertSpaces": true,
    "editor.detectIndentation": false,
    "editor.codeLens": true,
    "editor.autoIndent": "advanced",
    "editor.defaultFormatter": "kennylong.kubernetes-yaml-formatter",
    "diffEditor.ignoreTrimWhitespace": false,
    "editor.formatOnSave": true,
    "editor.quickSuggestions": {
      "other": true,
      "comments": true,
      "strings": true
    }
  },
  "gopls": {
    "staticcheck": true,
    "gofumpt": true,
    "analyses": {
      "unusedparams": true,
      "shadow": true
    }
  },
  "go.lintTool": "golangci-lint",
  "go.lintOnSave": "package",
  "Lua.diagnostics.globals": [
    "vim"
  ],
  "Lua.workspace.checkThirdParty": false,
  "Lua.telemetry.enable": false,
  "terraform.codelens.referenceCount": false,
  "terraform.experimentalFeatures.validateOnSave": true,
  "[go]": {
    "editor.tabSize": 4,
    "editor.insertSpaces": false,
    "editor.defaultFormatter": "golang.go",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.organizeImports": "explicit"
    }
  },
  "[python]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "ms-python.autopep8"
  },
  "[json]": {
    "editor.quickSuggestions": {
      "strings": true
    },
    "editor.defaultFormatter": "vscode.json-language-features",
    "editor.formatOnSave": true
  },
  "[nix]": {
    "editor.tabSize": 2,
    "editor.codeLens": true,
    "editor.formatOnSave": true
  },
  "[terraform]": {
    "editor.tabSize": 2,
    "editor.insertSpaces": true,
    "editor.detectIndentation": false,
    "editor.defaultFormatter": "hashicorp.terraform",
    "editor.formatOnSave": true
  },
  "[terraform-vars]": {
    "editor.tabSize": 2,
    "editor.insertSpaces": true,
    "editor.detectIndentation": false,
    "editor.defaultFormatter": "hashicorp.terraform",
    "editor.formatOnSave": true
  },
  "[lua]": {
    "editor.tabSize": 2,
    "editor.insertSpaces": true,
    "editor.detectIndentation": false
  },
  "[shellscript]": {
    "editor.tabSize": 2,
    "editor.insertSpaces": true,
    "editor.detectIndentation": false
  },
  "[c]": {
    "editor.tabSize": 2,
    "editor.insertSpaces": true,
    "editor.detectIndentation": false,
    "editor.rulers": [
      100
    ],
    "editor.formatOnSave": true
  },
  "[dockerfile]": {
    "editor.tabSize": 2,
    "editor.insertSpaces": true
  },
  "[markdown]": {
    "editor.wordWrap": "on",
    "editor.quickSuggestions": {
      "other": true,
      "comments": true,
      "strings": true
    }
  }
}
