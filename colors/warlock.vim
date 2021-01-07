" vim: foldmethod=marker

scriptencoding utf-8

if v:version > 580
    highlight clear

    if exists('syntax_on')
        syntax reset
    endif
endif

set background=dark

let g:colors_name = 'warlock'

" Configuration {{{
" Load a configuration variable {{{
function! s:load_config_var(name, default, set_script_local) abort
    let config_var = g:colors_name . '#' . a:name
    let type = get({
        \0: '%d',
        \1: "'%s'",
        \5: '%f',
        \6: '%d',
    \}, a:default, "'%s'")

    let load = printf("let g:%s = get(g:, '%s', %s)", config_var, config_var, type)

    " Set global variable
    execute printf(load, a:default)

    " Set script-local variable initialised from global counterpart
    if a:set_script_local
        execute printf("let s:%s = %s == 1 ? '%s' : ''", a:name, 'g:' . config_var, a:name)
    endif
endfunction
" }}}

call s:load_config_var('debug', 0, 0)
call s:load_config_var('bold', 1, 1)
call s:load_config_var('italic', 1, 1)
call s:load_config_var('underline', 1, 1)
call s:load_config_var('undercurl', 1, 1)
call s:load_config_var('italic_strings', 1, 1)
" }}}

" Color palette {{{
" Alt purple: #9f7ee7 #68588a
" browns: #ba8484 #d29494
" Alt green: #a4bd8e #84ba84
" Alt blue: #90a1b2
let s:palette = {
    \'none':       ['NONE',    'NONE', 'NONE'],
    \'fg0':        ['#bcbfbd', '253',  'Gray'],
    \'fg1':        ['#e3dac9', '253',  'Gray'],
    \'bg0':        ['#282c34', '235',  'DarkGray'],
    \'bg1':        ['#424855', '237',  'DarkBlue'],
    \'bg2':        ['#343944', '235',  'Black'],
    \'blue':       ['#8ea2b8', '111',  'Blue'],
    \'brown':      ['#d29494', '180',  'DarkRed'],
    \'cyan':       ['#8cbeb7', '159',  'LightCyan'],
    \'darkgreen':  ['#475b35', '22',   'DarkGreen'],
    \'darkpurple': ['#564c6c', '99',   'DarkMagenta'],
    \'darkred':    ['#b74f89', '126',  'DarkRed'],
    \'gray':       ['#c5c5c5', '250',  'LightGray'],
    \'green':      ['#a4bd8e', '85',   'LightGreen'],
    \'lightblue':  ['#97b7f3', '111',  'LightBlue'],
    \'lightgreen': ['#b5d5b5', '121',  'Green'],
    \'orange':     ['#dd9364', '216',  'DarkYellow'],
    \'pink':       ['#e9a6e9', '219',  'LightRed'],
    \'purple':     ['#6c6cbe', '141',  'Purple'],
    \'red':        ['#cd85ad', '218',  'Red'],
    \'white':      ['#eae9fe', '254',  'White'],
    \'yellow':     ['#d2ad8e', '224',  'LightYellow'],
\}
" }}}

" Functions {{{
" Emit an error message {{{
function! s:Error(msg) abort
    echoerr printf('vim-%s: %s', g:colors_name, a:msg)
endfunction
" }}}

" Set up a highlight group with a name, colors and attributes {{{
function! s:Highlight(group, fg, bg, ...) abort
    let l:hi = [
        \'hi ' . a:group,
        \'guifg=' . a:fg[0],
        \'guibg=' . a:bg[0],
        \'ctermfg=' . a:fg[1],
        \'ctermbg=' . a:bg[1],
    \]

    if a:0 > 0
        let attributes = join(a:000, ',')

        call add(l:hi, 'gui=' . attributes)
        call add(l:hi, 'cterm=' . attributes)
    endif

    execute join(l:hi, ' ')
endfunction
" }}}
" }}}

let s:style_idx = &background == 'light'

" Colors from the palette
call s:Highlight('None',       s:palette.none,       s:palette.none)
call s:Highlight('Fg0',        s:palette.fg0,        s:palette.none)
call s:Highlight('Fg1',        s:palette.fg1,        s:palette.none)
call s:Highlight('Bg0',        s:palette.bg0,        s:palette.none)
call s:Highlight('Bg1',        s:palette.bg1,        s:palette.none)
call s:Highlight('Bg2',        s:palette.bg2,        s:palette.none)
call s:Highlight('Blue',       s:palette.blue,       s:palette.none)
call s:Highlight('Brown',      s:palette.brown,      s:palette.none)
call s:Highlight('Cyan',       s:palette.cyan,       s:palette.none)
call s:Highlight('DarkGreen',  s:palette.darkgreen,  s:palette.none)
call s:Highlight('DarkPurple', s:palette.darkpurple, s:palette.none)
call s:Highlight('DarkRed',    s:palette.darkred,    s:palette.none)
call s:Highlight('Gray',       s:palette.gray,       s:palette.none)
call s:Highlight('Green',      s:palette.green,      s:palette.none)
call s:Highlight('LightBlue',  s:palette.lightblue,  s:palette.none)
call s:Highlight('LightGreen', s:palette.lightgreen, s:palette.none)
call s:Highlight('Orange',     s:palette.orange,     s:palette.none)
call s:Highlight('Pink',       s:palette.pink,       s:palette.none)
call s:Highlight('Purple',     s:palette.purple,     s:palette.none)
call s:Highlight('Red',        s:palette.red,        s:palette.none)
call s:Highlight('White',      s:palette.white,      s:palette.none)
call s:Highlight('Yellow',     s:palette.yellow,     s:palette.none)

" UI elements
call s:Highlight('ColorColumn',  s:palette.none,   s:palette.darkpurple)
call s:Highlight('Conceal',      s:palette.gray,   s:palette.none)
call s:Highlight('Cursor',       s:palette.purple, s:palette.purple)
call s:Highlight('CursorColumn', s:palette.purple, s:palette.bg2)
call s:Highlight('CursorLine',   s:palette.none,   s:palette.bg2)
call s:Highlight('CursorLineNr', s:palette.green,  s:palette.bg1)
call s:Highlight('Directory',    s:palette.orange, s:palette.none)
call s:Highlight('FoldColumn',   s:palette.fg0,    s:palette.bg1)
call s:Highlight('Folded',       s:palette.fg0,    s:palette.bg1)
call s:Highlight('LineNr',       s:palette.blue,   s:palette.bg0)
call s:Highlight('MatchParen',   s:palette.fg0,    s:palette.purple)
call s:Highlight('Normal',       s:palette.fg1,    s:palette.bg0)
call s:Highlight('Pmenu',        s:palette.none,   s:palette.darkpurple)
call s:Highlight('PmenuSel',     s:palette.none,   s:palette.purple)
call s:Highlight('PmenuSbar',    s:palette.none,   s:palette.blue)
"call s:Highlight('QuickFixLine', s:palette., s:palette.)
call s:Highlight('PmenuThumb',   s:palette.none,   s:palette.purple)
call s:Highlight('TabLine',      s:palette.none,   s:palette.purple)
call s:Highlight('TabLineFill',  s:palette.none,   s:palette.purple)
call s:Highlight('TabLineSel',   s:palette.none,   s:palette.yellow)
call s:Highlight('VertSplit',    s:palette.none,   s:palette.bg2)
call s:Highlight('Visual',       s:palette.none,   s:palette.darkpurple)
call s:Highlight('WildMenu',     s:palette.bg0,    s:palette.fg0)

" Diff
call s:Highlight('DiffAdd',    s:palette.none,   s:palette.darkgreen)
call s:Highlight('DiffDelete', s:palette.none,   s:palette.darkred)
call s:Highlight('DiffChange', s:palette.none,   s:palette.yellow)
call s:Highlight('DiffText',   s:palette.orange, s:palette.none)

" Language elements
call s:Highlight('Boolean',         s:palette.yellow,     s:palette.none)
call s:Highlight('Character',       s:palette.lightgreen, s:palette.none)
call s:Highlight('Comment',         ['#646e82', '235', 'Black'],            s:palette.none)
"call s:Highlight('Conceal',         s:palette.,           s:palette.)
call s:Highlight('Conditional',     s:palette.cyan,       s:palette.none)
call s:Highlight('Constant',        s:palette.brown,      s:palette.none)
call s:Highlight('Debug',           s:palette.yellow,     s:palette.none)
call s:Highlight('Define',          s:palette.lightgreen, s:palette.none)
call s:Highlight('Delimiter',       s:palette.blue,       s:palette.none)
call s:Highlight('Error',           s:palette.none,       s:palette.darkred)
call s:Highlight('ErrorMsg',        s:palette.none,       s:palette.darkred)
call s:Highlight('Exception',       s:palette.darkred,    s:palette.none)
call s:Highlight('Float',           s:palette.pink,       s:palette.none)
call s:Highlight('Function',        s:palette.blue,       s:palette.none)
call s:Highlight('Identifier',      s:palette.cyan,       s:palette.none)
call s:Highlight('Ignore',          s:palette.fg0,        s:palette.none)
call s:Highlight('Include',         s:palette.yellow,     s:palette.none)
call s:Highlight('IncSearch',       s:palette.yellow,     s:palette.none)
call s:Highlight('Keyword',         s:palette.orange,     s:palette.none)
call s:Highlight('Label',           s:palette.darkred,    s:palette.none)
call s:Highlight('Macro',           s:palette.lightgreen, s:palette.none)
call s:Highlight('Number',          s:palette.pink,       s:palette.none)
call s:Highlight('Operator',        s:palette.yellow,     s:palette.none)
call s:Highlight('PreCondit',       s:palette.lightgreen, s:palette.none)
call s:Highlight('PreProc',         s:palette.lightgreen, s:palette.none)
call s:Highlight('Question',        s:palette.cyan,       s:palette.none)
call s:Highlight('Repeat',          s:palette.cyan,       s:palette.none)
"call s:Highlight('SignColumn',      s:palette.,           s:palette.none)
call s:Highlight('Search',          s:palette.bg0,        s:palette.yellow)
call s:Highlight('Special',         s:palette.brown,      s:palette.none)
call s:Highlight('SpellBad',        s:palette.darkred,    s:palette.none, s:undercurl)
call s:Highlight('SpellCap',        s:palette.yellow,     s:palette.none, s:undercurl)
call s:Highlight('SpellLocal',      s:palette.blue,       s:palette.none, s:undercurl)
call s:Highlight('SpellRare',       s:palette.brown,      s:palette.none, s:undercurl)
call s:Highlight('StatusLine',      s:palette.none,       s:palette.purple)
call s:Highlight('StorageClass',    s:palette.red,       s:palette.none)
"call s:Highlight('StatusLineNC',    s:palette.none,       s:palette.purple)
call s:Highlight('Statement',       s:palette.purple,     s:palette.none)
call s:Highlight('String',          s:palette.green,      s:palette.none, s:italic)
call s:Highlight('StringDelimiter', s:palette.green,      s:palette.none, s:italic)
call s:Highlight('Title',           s:palette.purple,     s:palette.none, s:bold)
call s:Highlight('Structure',       s:palette.lightblue,  s:palette.none)
call s:Highlight('Tag',             s:palette.blue,       s:palette.none)
call s:Highlight('Todo',            s:palette.darkred,    s:palette.none)
call s:Highlight('Type',            s:palette.blue,       s:palette.none)
call s:Highlight('Quote',           s:palette.lightgreen, s:palette.none)
call s:Highlight('Underlined',      s:palette.fg0,        s:palette.none, s:underline)
call s:Highlight('WarningMsg',      s:palette.bg0,        s:palette.orange)

" Neovim/vim specific highlights
if has('nvim')
    call s:Highlight('NormalFloat', s:palette.none, s:palette.bg1)
    call s:Highlight('TermCursor', s:palette.none, s:palette.none, 'reverse')
    call s:Highlight('TermCursorNC', s:palette.purple, s:palette.none, 'reverse')
else
    "call s:Highlight('StatusLineTerm', s:palette.red, s:palette.none)
    "call s:Highlight('StatusLineTermNC', , )
endif

" Short-cut command for linking highlight groups
command! -buffer -nargs=+ HiLink highlight! link <args>

" Diff {{{
"diffAdded
"diffRemoved
"diffChanged
"diffFile
"diffNewFile
"diffLine

" gitcommit {{{
HiLink gitcommitHeader        Yellow
HiLink gitcommitSelectedFile  Green
HiLink gitcommitDiscardedFile Red
HiLink gitcommitUntrackedFile Purple
" }}}

" html {{{
call s:Highlight('htmlBold', s:palette.none, s:palette.none, s:bold)
call s:Highlight('htmlBoldItalic', s:palette.none, s:palette.none, s:bold, s:italic)
call s:Highlight('htmlItalic', s:palette.none, s:palette.none, s:italic)

"htmlTag
"htmlEndTag
"htmlTagName
"htmlTag
"htmlArg
"htmlScriptTag
"htmlTagN
"htmlSpecialTagName
"htmlLink
"htmlSpecialChar
" }}}

" css {{{
"HiLink cssFunctionName SrceryYellow
"HiLink cssIdentifier SrceryBlue
"HiLink cssClassName SrceryBlue
"HiLink cssClassNameDot SrceryBlue
"HiLink cssColor SrceryBrightMagenta
"HiLink cssSelectorOp SrceryBlue
"HiLink cssSelectorOp2 SrceryBlue
"HiLink cssImportant SrceryGreen
HiLink cssVendor Yellow
HiLink cssMediaProp Cyan
HiLink cssBorderProp Yellow
"HiLink cssAttrComma SrceryBrightWhite
HiLink cssValueLength Red
HiLink cssValueNumber Red
HiLink cssUnitDecorators Red

HiLink cssTextProp Green
"HiLink cssAnimationProp SrceryYellow
HiLink cssUIProp Yellow
"HiLink cssTransformProp SrceryYellow
"HiLink cssTransitionProp SrceryYellow
"HiLink cssPrintProp SrceryYellow
HiLink cssPositioningProp Yellow
HiLink cssBoxProp Cyan
"HiLink cssFontDescriptorProp SrceryYellow
"HiLink cssFlexibleBoxProp SrceryYellow
"HiLink cssBorderOutlineProp SrceryYellow
"HiLink cssBackgroundProp SrceryYellow
"HiLink cssMarginProp SrceryYellow
"HiLink cssListProp SrceryYellow
"HiLink cssTableProp SrceryYellow
HiLink cssFontProp Yellow
"HiLink cssPaddingProp SrceryYellow
"HiLink cssDimensionProp SrceryYellow
"HiLink cssRenderProp SrceryYellow
"HiLink cssColorProp SrceryYellow
"HiLink cssGeneratedContentProp SrceryYellow
"HiLink cssTagName SrceryBrightBlue
" }}}

" xml {{{
HiLink xmlTag Purple
HiLink xmlEndTag Red
HiLink xmlTagName Identifier
HiLink xmlEqual Operator
"docbkKeyword

"xmlDocTypeDecl
"xmlDocTypeKeyword
"xmlCdataStart
"xmlCdataCdata
"dtdFunction
"dtdTagName

"xmlAttrib
"xmlProcessingDelim
"dtdParamEntityPunct
"dtdParamEntityDPunct
"xmlAttribPunct

"xmlEntity
"xmlEntityPunct
" }}}

" vim {{{
HiLink vimUserFunc   Function
HiLink vimNotFunc    Conditional
HiLink vimFunction   Red
HiLink vimVar        Brown
HiLink vimSet        LightBlue
HiLink vimSetEqual   LightBlue
HiLink vimAugroupKey Yellow
HiLink vimFuncVar    Orange
" }}}

" C {{{
"cOperator
"cStructure
" }}}

" C++ {{{
HiLink cppModifier Brown
" }}}

" c# (https://github.com/nickspoons/vim-cs) {{{
"HiLink csUnspecifiedStatement PurpleItalic
"HiLink csStorage RedItalic
"HiLink csClass RedItalic
"HiLink csNewType Cyan
"HiLink csContextualStatement PurpleItalic
"HiLink csInterpolationDelimiter Yellow
"HiLink csInterpolation Yellow
"HiLink csEndColon Fg
" }}}

" Python {{{
" Syntax groups from vim's python.vim
HiLink pythonAsync         Red
HiLink pythonBuiltin       Red
HiLink pythonBuiltinFunc   Red
HiLink pythonDecorator     Yellow
HiLink pythonDecoratorName Red
HiLink pythonExceptions    Exception
HiLink pythonFunction      Function

" From https://github.com/vim-python/python-syntax
HiLink pythonBoolean            Boolean
HiLink pythonBuiltinObj         Red
HiLink pythonBuiltinType        Red
HiLink pythonClass              Yellow
HiLink pythonClassVar           Identifier
HiLink pythonCoding             Special
HiLink pythonDot                Pink
HiLink pythonDottedName         Red
HiLink pythonExClass            Exception
HiLink pythonImport             Orange
HiLink pythonRaiseFromStatement Yellow

"call s:Highlight('pythonIndentError', s:palette.none, s:palette.darkred, s:undercurl)
"call s:Highlight('pythonNumberError', s:palette.pink, s:palette.red)
"HiLink pythonNumberError Red
" }}}

" Perl (https://github.com/vim-perl/vim-perl) {{{
"HiLink perlStatementPackage PurpleItalic
"HiLink perlStatementInclude PurpleItalic
"HiLink perlStatementStorage Orange
"HiLink perlStatementList Orange
"HiLink perlMatchStartEnd Orange
"HiLink perlVarSimpleMemberName Cyan
"HiLink perlVarSimpleMember Fg
"HiLink perlMethod Green
"HiLink podVerbatimLine Green
"HiLink podCmdText Yellow
" }}}

" JavaScript {{{

" }}}

" JSX {{{
" }}}

" Typescript {{{
"
" or brown strings?
HiLink typescriptStringS      Green
HiLink typescriptStorageClass Red

" From https://github.com/HerringtonDarkholme/yats.vim
HiLink typescriptDestructureVariable       Brown
"HiLink typescriptMethodAccessor            OrangeItalic
HiLink typescriptVariable                  Identifier
HiLink typescriptVariableDeclaration       Yellow
HiLink typescriptTypeReference             LightBlue
"HiLink typescriptBraces                    Fg
HiLink typescriptEnumKeyword               Type
HiLink typescriptEnum                      Yellow
HiLink typescriptIdentifierName            Identifier
HiLink typescriptProp                      Cyan
"HiLink typescriptCall                      Blue
HiLink typescriptInterfaceName             Yellow
"HiLink typescriptEndColons                 Fg
HiLink typescriptMember                    White
HiLink typescriptPredefinedType            Type
"HiLink typescriptMemberOptionality         Orange
HiLink typescriptObjectLabel               Blue
HiLink typescriptArrowFunc                 Function
"HiLink typescriptAbstract                  Orange
"HiLink typescriptObjectColon               Grey
"HiLink typescriptTypeAnnotation            Grey
HiLink typescriptAssign                    Operator
HiLink typescriptBinaryOp                  Operator
HiLink typescriptUnaryOp                   Operator
"HiLink typescriptFuncComma                 Fg
HiLink typescriptClassName                 Identifier
"HiLink typescriptClassHeritage             Yellow
"HiLink typescriptInterfaceHeritage         Yellow
"HiLink typescriptIdentifier                Purple
HiLink typescriptGlobal                    Red
HiLink typescriptOperator                  Operator
"HiLink typescriptNodeGlobal                PurpleItalic
HiLink typescriptExport                    Orange
"HiLink typescriptDefaultParam              Orange
HiLink typescriptInterfaceKeyword Structure
HiLink typescriptImport Orange
"HiLink typescriptTypeParameter             Yellow
"HiLink typescriptReadonlyModifier          Orange
"HiLink typescriptAccessibilityModifier     Orange
"HiLink typescriptAmbientDeclaration        RedItalic
"HiLink typescriptTemplateSubstitution      Yellow
"HiLink typescriptTemplateSB                Yellow
HiLink typescriptExceptions                Exception
"HiLink typescriptCastKeyword               RedItalic
HiLink typescriptOptionalMark              Red
HiLink typescriptNull                      DarkRed
"HiLink typescriptMappedIn                  RedItalic
HiLink typescriptFuncKeyword               Yellow
HiLink typescriptTry                       typescriptExceptions
HiLink typescriptAsyncFuncKeyword          Cyan
HiLink typescriptAliasKeyword              Brown
HiLink typescriptDefault                   Blue
"HiLink typescriptFuncTypeArrow             Function
"HiLink typescriptTernaryOp                 Orange
"HiLink typescriptParenExp                  Blue
"HiLink typescriptIndexExpr                 Blue
"HiLink typescriptDotNotation               Grey
"HiLink typescriptGlobalNumberDot           Grey
"HiLink typescriptGlobalStringDot           Grey
"HiLink typescriptGlobalArrayDot            Grey
"HiLink typescriptGlobalObjectDot           Grey
"HiLink typescriptGlobalSymbolDot           Grey
"HiLink typescriptGlobalMathDot             Grey
"HiLink typescriptGlobalDateDot             Grey
"HiLink typescriptGlobalJSONDot             Grey
"HiLink typescriptGlobalRegExpDot           Grey
"HiLink typescriptGlobalPromiseDot          Grey
"HiLink typescriptGlobalURLDot              Grey
"HiLink typescriptGlobalMethod              Green
"HiLink typescriptDOMStorageMethod          Green
"HiLink typescriptFileMethod                Green
"HiLink typescriptFileReaderMethod          Green
"HiLink typescriptFileListMethod            Green
"HiLink typescriptBlobMethod                Green
HiLink typescriptURLStaticMethod           LightGreen
HiLink typescriptNumberStaticMethod        typescriptURLStaticMethod
"HiLink typescriptNumberMethod              Green
"HiLink typescriptDOMNodeMethod             Green
"HiLink typescriptPaymentMethod             Green
"HiLink typescriptPaymentResponseMethod     Green
"HiLink typescriptHeadersMethod             Green
"HiLink typescriptRequestMethod             Green
"HiLink typescriptResponseMethod            Green
"HiLink typescriptES6SetMethod              Green
"HiLink typescriptReflectMethod             Green
"HiLink typescriptBOMWindowMethod           Green
"HiLink typescriptGeolocationMethod         Green
"HiLink typescriptServiceWorkerMethod       Green
"HiLink typescriptCacheMethod               Green
"HiLink typescriptES6MapMethod              Green
"HiLink typescriptFunctionMethod            Green
"HiLink typescriptRegExpMethod              Green
"HiLink typescriptXHRMethod                 Green
"HiLink typescriptBOMNavigatorMethod        Green
"HiLink typescriptServiceWorkerMethod       Green
"HiLink typescriptIntlMethod                Green
"HiLink typescriptDOMEventTargetMethod      Green
"HiLink typescriptDOMEventMethod            Green
"HiLink typescriptDOMDocMethod              Green
HiLink typescriptStringStaticMethod        typescriptURLStaticMethod
HiLink typescriptStringMethod              typescriptGlobal
HiLink typescriptSymbolStaticMethod        typescriptURLStaticMethod
HiLink typescriptObjectStaticMethod        typescriptURLStaticMethod
"HiLink typescriptObjectMethod              Green
HiLink typescriptJSONStaticMethod          typescriptURLStaticMethod
"HiLink typescriptEncodingMethod            Green
"HiLink typescriptBOMLocationMethod         Green
HiLink typescriptPromiseStaticMethod       typescriptURLStaticMethod
"HiLink typescriptPromiseMethod             Green
"HiLink typescriptSubtleCryptoMethod        Green
"HiLink typescriptCryptoMethod              Green
"HiLink typescriptBOMHistoryMethod          Green
"HiLink typescriptDOMFormMethod             Green
"HiLink typescriptConsoleMethod             Green
HiLink typescriptDateStaticMethod          typescriptURLStaticMethod
"HiLink typescriptDateMethod                Green
HiLink typescriptArrayStaticMethod         typescriptURLStaticMethod
"HiLink typescriptArrayMethod               Green
HiLink typescriptMathStaticMethod          typescriptGlobal
"HiLink typescriptStringProperty            Cyan
"HiLink typescriptDOMStorageProp            Cyan
"HiLink typescriptFileReaderProp            Cyan
"HiLink typescriptURLUtilsProp              Cyan
"HiLink typescriptNumberStaticProp          Cyan
"HiLink typescriptDOMNodeProp               Cyan
"HiLink typescriptBOMWindowProp             Cyan
"HiLink typescriptRequestProp               Cyan
"HiLink typescriptResponseProp              Cyan
"HiLink typescriptPaymentProp               Cyan
"HiLink typescriptPaymentResponseProp       Cyan
"HiLink typescriptPaymentAddressProp        Cyan
"HiLink typescriptPaymentShippingOptionProp Cyan
"HiLink typescriptES6SetProp                Cyan
"HiLink typescriptServiceWorkerProp         Cyan
"HiLink typescriptES6MapProp                Cyan
"HiLink typescriptRegExpStaticProp          Cyan
"HiLink typescriptRegExpProp                Cyan
"HiLink typescriptBOMNavigatorProp          Green
"HiLink typescriptXHRProp                   Cyan
"HiLink typescriptDOMEventProp              Cyan
"HiLink typescriptDOMDocProp                Cyan
"HiLink typescriptBOMNetworkProp            Cyan
"HiLink typescriptSymbolStaticProp          Cyan
"HiLink typescriptEncodingProp              Cyan
"HiLink typescriptBOMLocationProp           Cyan
"HiLink typescriptCryptoProp                Cyan
"HiLink typescriptDOMFormProp               Cyan
"HiLink typescriptBOMHistoryProp            Cyan
"HiLink typescriptMathStaticProp            Cyan
HiLink typescriptComment    Comment
HiLink typescriptDocComment Comment
HiLink typescriptDocTags    Title
" }}}

" TSX (Typescript + JSX) {{{
HiLink tsxTagName Red
"HiLink tsxCloseTagName
HiLink tsxAttrib  Yellow
" }}}

" Lua {{{
HiLink luaTable         Yellow
HiLink luaFunc          Function
HiLink luaFunction      Function
HiLink luaFunctionBlock Orange
" }}}

" MoonScript {{{
"HiLink moonSpecialOp SrceryBrightWhite
"HiLink moonExtendedOp SrceryBrightWhite
"HiLink moonFunction SrceryBrightWhite
"HiLink moonObject SrceryYellow
" }}}

" Java {{{

" }}}

" Kotlin: (https://github.com/udalov/kotlin-vim) {{{
"HiLink ktSimpleInterpolation Yellow
"HiLink ktComplexInterpolation Yellow
"HiLink ktComplexInterpolationBrace Yellow
"HiLink ktStructure RedItalic
"HiLink ktKeyword Cyan
" }}}

" Scala {{{

" }}}

" Markdown {{{
HiLink markdownH1 Yellow
HiLink markdownH2 Yellow
HiLink markdownH3 Yellow
HiLink markdownH4 Yellow
HiLink markdownH5 Yellow
HiLink markdownH6 Yellow
HiLink markdownCode Brown
HiLink markdownCodeBlock Brown
HiLink markdownCodeDelimiter Brown
HiLink markdownLinkDelimiter markdownUrl
HiLink markdownLinkTextDelimiter markdownLinkText
HiLink markdownUrl Red

call s:Highlight('markdownLinkText', s:palette.blue, s:palette.none, s:underline)
" }}}

" ReStructuredText: {{{
" }}}

" vimtex: {{{
" }}}

" Haskell {{{
"HiLink haskellType SrceryBlue
"HiLink haskellIdentifier SrceryBlue
"HiLink haskellSeparator SrceryBlue
"HiLink haskellDelimiter SrceryBrightWhite
"HiLink haskellOperators SrceryBlue

"HiLink haskellBacktick SrceryYellow
"HiLink haskellStatement SrceryYellow
"HiLink haskellConditional SrceryYellow

"HiLink haskellLet SrceryCyan
"HiLink haskellDefault SrceryCyan
"HiLink haskellWhere SrceryCyan
"HiLink haskellBottom SrceryCyan
"HiLink haskellBlockKeywords SrceryCyan
"HiLink haskellImportKeywords SrceryCyan
"HiLink haskellDeclKeyword SrceryCyan
"HiLink haskellDeriving SrceryCyan
"HiLink haskellAssocType SrceryCyan

"HiLink haskellNumber SrceryMagenta
"HiLink haskellPragma SrceryMagenta

"HiLink haskellString SrceryGreen
"HiLink haskellChar SrceryGreen
" }}}

" Json {{{
HiLink jsonKeyword Blue
HiLink jsonQuote Green
" }}}

" Yaml: {{{
HiLink yamlPlainScalar Normal
" }}}

" Toml: {{{
"call s:Highlight('tomlTable', s:palette.purple, s:palette.none, 'bold')
"HiLink tomlKey Orange
"HiLink tomlBoolean Cyan
"HiLink tomlTableArray tomlTable
" }}}

" Rust (https://github.com/rust-lang/rust.vim) {{{
"HiLink rustStructure Orange
"HiLink rustIdentifier Purple
"HiLink rustModPath Orange
"HiLink rustModPathSep Grey
"HiLink rustSelf Blue
"HiLink rustSuper Blue
"HiLink rustDeriveTrait PurpleItalic
"HiLink rustEnumVariant Purple
"HiLink rustMacroVariable Blue
"HiLink rustAssert Cyan
"HiLink rustPanic Cyan
"HiLink rustPubScopeCrate PurpleItalic
" }}}

" Make {{{
HiLink makeCommands Constant
HiLink makeSpecial Number
HiLink makeTarget Purple
HiLink makeSpecTarget DarkRed
" }}}

" CMake: {{{
"HiLink cmakeCommand Orange
"HiLink cmakeKWconfigure_package_config_file Yellow
"HiLink cmakeKWwrite_basic_package_version_file Yellow
"HiLink cmakeKWExternalProject Cyan
"HiLink cmakeKWadd_compile_definitions Cyan
"HiLink cmakeKWadd_compile_options Cyan
"HiLink cmakeKWadd_custom_command Cyan
"HiLink cmakeKWadd_custom_target Cyan
"HiLink cmakeKWadd_definitions Cyan
"HiLink cmakeKWadd_dependencies Cyan
"HiLink cmakeKWadd_executable Cyan
HiLink cmakeKWadd_library Pink
"HiLink cmakeKWadd_link_options Cyan
"HiLink cmakeKWadd_subdirectory Cyan
HiLink cmakeKWadd_test LightGreen
"HiLink cmakeKWbuild_command Cyan
"HiLink cmakeKWcmake_host_system_information Cyan
"HiLink cmakeKWcmake_minimum_required Cyan
"HiLink cmakeKWcmake_parse_arguments Cyan
"HiLink cmakeKWcmake_policy Cyan
"HiLink cmakeKWconfigure_file Cyan
"HiLink cmakeKWcreate_test_sourcelist Cyan
HiLink cmakeKWctest_build cmakeKWadd_test
HiLink cmakeKWctest_configure cmakeKWadd_test
HiLink cmakeKWctest_coverage cmakeKWadd_test
HiLink cmakeKWctest_memcheck cmakeKWadd_test
HiLink cmakeKWctest_run_script cmakeKWadd_test
HiLink cmakeKWctest_start cmakeKWadd_test
HiLink cmakeKWctest_submit cmakeKWadd_test
HiLink cmakeKWctest_test cmakeKWadd_test
HiLink cmakeKWctest_update cmakeKWadd_test
HiLink cmakeKWctest_upload cmakeKWadd_test
"HiLink cmakeKWdefine_property Cyan
"HiLink cmakeKWdoxygen_add_docs Cyan
"HiLink cmakeKWenable_language Cyan
HiLink cmakeKWenable_testing LightGreen
"HiLink cmakeKWexec_program Cyan
HiLink cmakeKWexecute_process Red
"HiLink cmakeKWexport Cyan
"HiLink cmakeKWexport_library_dependencies Cyan
"HiLink cmakeKWfile Cyan
"HiLink cmakeKWfind_file Cyan
"HiLink cmakeKWfind_library Cyan
HiLink cmakeKWfind_package Brown
"HiLink cmakeKWfind_path Cyan
"HiLink cmakeKWfind_program Cyan
"HiLink cmakeKWfltk_wrap_ui Cyan
"HiLink cmakeKWforeach Cyan
"HiLink cmakeKWfunction Cyan
HiLink cmakeKWget_cmake_property Brown
HiLink cmakeKWget_directory_property Directory
HiLink cmakeKWget_filename_component Directory
HiLink cmakeKWget_property Red
"HiLink cmakeKWget_source_file_property Cyan
"HiLink cmakeKWget_target_property Cyan
HiLink cmakeKWget_test_property cmakeKWadd_test
HiLink cmakeKWif Conditional
"HiLink cmakeKWinclude Cyan
"HiLink cmakeKWinclude_directories Cyan
"HiLink cmakeKWinclude_external_msproject Cyan
"HiLink cmakeKWinclude_guard Cyan
"HiLink cmakeKWinstall Cyan
"HiLink cmakeKWinstall_files Cyan
"HiLink cmakeKWinstall_programs Cyan
"HiLink cmakeKWinstall_targets Cyan
"HiLink cmakeKWlink_directories Cyan
"HiLink cmakeKWlist Cyan
"HiLink cmakeKWload_cache Cyan
"HiLink cmakeKWload_command Cyan
"HiLink cmakeKWmacro Cyan
"HiLink cmakeKWmark_as_advanced Cyan
"HiLink cmakeKWmath Cyan
HiLink cmakeKWmessage Orange
"HiLink cmakeKWoption Cyan
HiLink cmakeKWproject Title
"HiLink cmakeKWqt_wrap_cpp Cyan
"HiLink cmakeKWqt_wrap_ui Cyan
"HiLink cmakeKWremove Cyan
"HiLink cmakeKWseparate_arguments Cyan
HiLink cmakeKWset Yellow
HiLink cmakeKWset_directory_properties Directory
"HiLink cmakeKWset_property Cyan
"HiLink cmakeKWset_source_files_properties Cyan
"HiLink cmakeKWset_target_properties Cyan
HiLink cmakeKWset_tests_properties LightGreen
"HiLink cmakeKWsource_group Cyan
"HiLink cmakeKWstring Cyan
"HiLink cmakeKWsubdirs Cyan
"HiLink cmakeKWtarget_compile_definitions Cyan
"HiLink cmakeKWtarget_compile_features Cyan
"HiLink cmakeKWtarget_compile_options Cyan
"HiLink cmakeKWtarget_include_directories Cyan
"HiLink cmakeKWtarget_link_directories Cyan
HiLink cmakeKWtarget_link_libraries Pink
"HiLink cmakeKWtarget_link_options Cyan
"HiLink cmakeKWtarget_precompile_headers Cyan
"HiLink cmakeKWtarget_sources Cyan
"HiLink cmakeKWtry_compile Cyan
"HiLink cmakeKWtry_run Cyan
"HiLink cmakeKWunset Cyan
"HiLink cmakeKWuse_mangled_mesa Cyan
"HiLink cmakeKWvariable_requires Cyan
HiLink cmakeKWvariable_watch LightBlue
HiLink cmakeKWwrite_file Orange
HiLink cmakeKWmake_directory Directory
HiLink cmakeGeneratorExpressions Operator
" }}}

" bash {{{
" }}}

" fish shell {{{
HiLink fishCommandSub Red
" }}}

" Plugins: {{{
" ALE {{{
call s:Highlight('ALEError', s:palette.red, s:palette.none, s:undercurl)
call s:Highlight('ALEWarning', s:palette.orange, s:palette.none, s:undercurl)
call s:Highlight('ALEInfo', s:palette.blue, s:palette.none, s:undercurl)

HiLink ALEErrorSign   ALEError
HiLink ALEWarningSign ALEWarning
HiLink ALEInfoSign    ALEInfo
" }}}

" fzf.vim {{{
"HiLink fzf1 Purple
"HiLink fzf2 DarkPurple
"HiLink fzf3 Purple
"let g:fzf_colors = {
"      \ 'fg':      ['fg', 'Normal'],
"      \ 'bg':      ['bg', 'Normal'],
"      \ 'hl':      ['fg', 'Green'],
"      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"      \ 'hl+':     ['fg', 'Cyan'],
"      \ 'info':    ['fg', 'Cyan'],
"      \ 'prompt':  ['fg', 'Orange'],
"      \ 'pointer': ['fg', 'Blue'],
"      \ 'marker':  ['fg', 'Yellow'],
"      \ 'spinner': ['fg', 'Yellow'],
"      \ 'header':  ['fg', 'Grey']
"      \ }
" }}}

" Netrw {{{
"netrwDir
"netrwClassify
"netrwLink
"netrwSymLink
"netrwExe
"netrwComment
"netrwList
"netrwTreeBar
"netrwHelpCmd
"netrwVersion
"netrwCmdSep
" }}}

" CtrlP {{{
" CtrlPMode1
" CtrlPMode2
" CtrlPStats
"call s:Highlight('CtrlPMatch', s:palette.green, s:palette.none, 'bold')
"call s:Highlight('CtrlPPrtBase', s:palette.bg3, s:palette.none)
"call s:Highlight('CtrlPLinePre', s:palette.bg3, s:palette.none)
"call s:Highlight('CtrlPMode1', s:palette.blue, s:palette.bg3, 'bold')
"call s:Highlight('CtrlPMode2', s:palette.bg0, s:palette.blue, 'bold')
"call s:Highlight('CtrlPStats', s:palette.grey, s:palette.bg3, 'bold')
"HiLink CtrlPNoEntries Red
"HiLink CtrlPPrtCursor Blue
" }}}

" vim-exchange {{{
" ExchangeRegion
" }}}

" vim-task {{{
HiLink TaskUri         Green
HiLink DueTag          Pink
HiLink DoneSymbol      LightGreen
HiLink CancelledSymbol DarkRed
HiLink LowTag          Blue
HiLink MediumTag       Yellow
HiLink HighTag         Orange
HiLink CriticalTag     Red
" }}}

" junegunn/limelight.vim {{{
"let g:limelight_conceal_guifg = s:palette.grey[0]
"let g:limelight_conceal_ctermfg = s:palette.bg4[1]
" }}}

" majutsushi/tagbar{{{
"HiLink TagbarFoldIcon Green
"HiLink TagbarSignature Green
"HiLink TagbarKind Red
"HiLink TagbarScope Orange
"HiLink TagbarNestedKind Cyan
"HiLink TagbarVisibilityPrivate Red
HiLink TagbarVisibilityPublic Green
" }}}

" scrooloose/nerdtree{{{
HiLink NERDTreeDir Green
HiLink NERDTreeExecFile Yellow
HiLink NERDTreeFlags Blue
HiLink NERDTreeHelpTitle Title
HiLink NERDTreeLinkFile Blue
HiLink NERDTreeLinkTarget Pink
" }}}
"
" gitmessenger.vim {{{
HiLink gitmessengerHash Yellow
" }}}
" }}}

delcommand HiLink
