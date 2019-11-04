" jsxRegion
" jsxChild

" jsCssStyles
syn match jsClassName '\<[A-Z]\w\+\>' containedin=jsModuleKeyword,jsClassBlock,jsClassDefinition,jsFuncBlock,jsObjectValue,jsIfElseBlock,jsParen,jsBlock,jsParenIfElse,jsSwitchCase,jsFlowTypeStatement,jsFlowObject,jsFlowGroup


" Regexes / Sub Lang
hi!  jsRegexpString         guifg='#796A58' guibg='#230854'
hi!  jsRegexpCharClass      guifg='#483F50' guibg='#230854'
hi!  jsRegexpBoundary       guifg='#664D6E' guibg='#230854'
hi!  jsRegexpBackRef        guifg='#7F5583' guibg='#230854'
hi!  jsRegexpQuantifier     guifg='#68402F' guibg='#230854'
hi!  jsRegexpOr             guifg='#975E95' guibg='#230854'
hi!  jsRegexpMod            guifg='#AB629C' guibg='#230854'
hi!  jsRegexpGroup          guifg='#664D6E' guibg='#230854'


" Comments
hi!  jsComment                 guifg='#5B4B43'
hi!  jsCommentFunction         guifg='#5B4B43'
hi!  jsCommentClass            guifg='#5B4B43'
hi!  jsCommentIfElse           guifg='#5B4B43'
hi!  jsCommentTodo             guifg='#FF3333' guibg='#241C1C'
hi!  jsEnvComment              guifg='#843C35' guibg='#322726'


" Noise
hi! jsNoise                   guifg='#443533'

hi! link jsBrackets jsNoise
hi! link jsFuncParens jsNoise
hi! link jsModuleBraces jsNoise
hi! link jsModuleComma jsNoise
hi! link jsDestructuringBraces jsNoise
hi! link jsObjectBraces jsNoise
hi! link jsDestructuringArray jsNoise
hi! link jsSwitchColon jsNoise
hi! link jsParens jsNoise
hi! link jsParensDecorator jsNoise
hi! link jsParenDecorator jsNoise
hi! link jsParensIfElse jsNoise
hi! link jsParensRepeat jsNoise
hi! link jsCommentRepeat jsNoise
hi! link jsParensSwitch jsNoise
hi! link jsParensCatch jsNoise
hi! link jsFuncArgCommas jsNoise
hi! link jsFuncBraces jsNoise
hi! link jsIfElseBraces jsNoise
hi! link jsTryCatchBraces jsNoise
hi! link jsFinallyBraces jsNoise
hi! link jsSwitchBraces jsNoise
hi! link jsRepeatBraces jsNoise
hi! link jsClassBraces jsNoise
hi! link jsBraces jsNoise
hi! link jsClassNoise jsNoise
hi! link jsObjectColon jsNoise
hi! link jsObjectSeparator jsNoise
hi! link jsDestructuringNoise jsNoise

" Misc
hi! jsParensError       guifg='#FF625E'
hi! jsOperator          guifg='#8C7168'
hi! jsModuleAsterisk    guifg='#9D8275'
hi! jsModuleGroup       guifg='#A9917E'
hi! jsDecorator         guifg='#CCAFAA'
hi! jsDecoratorFunction guifg='#D8C0B6'
hi! jsSpreadOperator    guifg='#E3D0C4'
hi! jsRestOperator      guifg='#E9DBCC'
hi! jsOf                guifg='#9D8275'
hi! jsModuleAs          guifg='#7E625E'

" Program Structure
hi! jsPrototype              guifg='#1F6C6B'
hi! jsModuleKeyword          guifg='#20806A'

hi! jsFuncName               guifg='#469870'
hi! link jsClassFuncName jsFuncName

hi! jsClassKeyword           guifg='#75B47A'
hi! jsExtendsKeyword         guifg='#817B60'

hi! jsImport                 guifg='#8CC47B'
hi! jsExport                 guifg='#505B1E'
hi! jsExportDefault          guifg='#626B20'
hi! jsFrom                   guifg='#777922'
hi! jsExportDefaultGroup     guifg='#898B23'
hi! jsFunctionKey            guifg='#9D9F28'
"

hi! jsClassMethodType        guifg='#A9A37E'
hi! jsGenerator              guifg='#CCC9AA'
hi! jsClassDefinition        guifg='#958E6F'

" Variable Type
hi! jsNull                   guifg='#8D492B'
hi! jsThis                   guifg='#9C522F'
hi! jsUndefined              guifg='#AD5E33'
hi! jsSpecial                guifg='#BF6B3E'
hi! jsNan                    guifg='#CF7B43'

hi! jsBooleanTrue            guifg='#843C35'
hi! link jsBooleanFalse jsBooleanTrue
hi! jsNumber                 guifg='#AD6143'
hi! jsFloat                  guifg='#9C4C3D'
hi! jsStorageClass           guifg='#C99147'
hi! jsObjectKey              guifg='#BA7845'


"Scope Resolution
hi! jsObjectValue               guifg='#ddddee'
hi! jsObjectKeyString           guifg='#784452'
hi! jsObjectStringKey           guifg='#784452'
hi! jsObjectKeyComputed         guifg='#904851'
hi! jsObjectFuncName            guifg='#C1604D'
hi! jsObjectMethodType          guifg='#D47055'
hi! jsClassProperty             guifg='#A84E4E'
hi! jsObjectProp                guifg='#A84E4E'

" Constants
hi! jsClassName                  guifg='#ECCF49'
hi! jsGlobalObjects              guifg='#B28142'
hi! jsGlobalNodeObjects          guifg='#B28142'
hi! jsError                      guifg='#CDA544'
hi! jsBuiltins                   guifg='#945F3C'

" jsDomErrNo
" jsDomNodeConsts
" jsHtmlEvents
" jsDomElemAttrs
" jsDomElemFuncs
" jsHtmlElemAttrs
" jsHtmlElemFuncs



" Code Regions
hi! jsObjectValue                guifg='#b8b8c9'
hi! jsBlock                      guifg='#a09fb1'
hi! jsParenIfElse                guifg='#a09fb1'
hi! jsParenSwitch                guifg='#a09fb1'
hi! jsParenRepeat                guifg='#a09fb1'
hi! jsParenCatch                 guifg='#a09fb1'
hi! jsIfElseBlock                guifg='#9494a5'
hi! jsRepeatBlock                guifg='#9494a5'
hi! jsTryCatchBlock              guifg='#888899'
hi! jsFinallyBlock               guifg='#888899'
hi! jsRestExpression             guifg='#d1d0e2'
hi! jsFuncBlock                  guifg='#c4c4d5'
hi! jsBracket                    guifg='#c4c4d5'
hi! jsParen                      guifg='#acabbd'
hi! jsSpreadExpression           guifg='#acabbd'


hi! jsArrowFuncArgs                  guifg='#93573F'
hi! link jsFuncArgs jsArrowFuncArgs

hi! jsDestructuringBlock             guifg='#CCAFAA'
hi! jsDestructuringProperty          guifg='#E9DBCC'
hi! jsDestructuringAssignment        guifg='#D8C0B6'
hi! jsDestructuringPropertyComputed  guifg='#E3D0C4'
hi! jsDestructuringPropertyValue     guifg='#E9DBCC'
hi! jsDestructuringValueAssignment   guifg='#D8C0B6'

" Control
hi! jsFuncCall                  guifg='#046CA5'

hi! jsFunction                  guifg='#046397'
hi! jsArrowFunction             guifg='#046397'

hi! jsReturn                    guifg='#0480A4'
hi! jsSuper                     guifg='#1398A9'

hi! jsStatement                 guifg='#26A4AD'

hi! jsConditional               guifg='#36B4B0'
hi! jsSwitchCase                guifg='#36B4B0'
hi! jsTernaryIfOperator         guifg='#36B4B0'
hi! jsTernaryIf                 guifg='#36B4B0'
hi! jsBranch                    guifg='#36B4B0'
hi! jsBlockLabel                guifg='#36B4B0'
hi! link jsBlockLabelKey jsBlockLabel
hi! link jsLabel jsBlockLabel

hi! jsRepeat                    guifg='#4DC4B1'

hi! jsForAwait                  guifg='#54DEB2'
hi! jsDo                        guifg='#54DEB2'
hi! jsAsyncKeyword              guifg='#54DEB2'

hi! jsTry                       guifg='#A26846'
hi! jsFinally                   guifg='#B67D4F'
hi! jsCatch                     guifg='#BF8953'
hi! jsException                 guifg='#C59759'
hi! jsExceptions                guifg='#CBA65B'


" Strings
hi! jsTemplateExpression         guifg='#5D392A'
hi! jsTaggedTemplate             guifg='#68402F'
hi! jsString                     guifg='#7A4830'
hi! jsTemplateString             guifg='#885735'
hi! jsTemplateBraces             guifg='#976538'
hi! jsClassStringKey             guifg='#A3743B'
hi! jsCharacter                  guifg='#AF873E'



" Flow
hi! link jsFlowImportType jsStorageClass
hi! link jsFlowTypeStatement jsStorageClass
hi! link jsFlowObject jsObject

" jsVariableDef
" jsFlowClassDef
" jsFlowClassGroup
" jsFlowReturn
" jsFlowArgumentDef
" jsFlowFunctionGroup
" jsFuncArgOperator
" jsFlowTypeKeyword
" jsFlowTypeStatement
" jsFlowObject
" jsFlowStringLiteral
" jsFlowArrayDeclaration
" jsFlowDefinition
" jsFlowGroup
" jsFlowTypeValue
" jsFlowNoise
" jsFlowArray
" jsFlowExactObject
" jsFlowParens
" jsFlowType
" jsFlowTypeof
" jsFlowTypeCustom
" jsFlowArrow
" jsFlowArrowArguments
" jsFlowMaybe
" jsFlowObjectKey
" jsFlowOrOperator
" jsFlowWildcard
" jsFlowReturnParens
" jsFlowReturnOrOp
" jsFlowReturnObject
" jsFlowReturnArray
" jsFlowReturnArrow
" jsFlowReturnGroup
" jsFlowReturnKeyword
" jsFlowReturnMaybe
" jsFlowWildcardReturn
" jsFlowTypeOperator
" jsFlowDeclare
" jsFlowModule
" jsFlowInterface
" jsFlowClassProperty
" jsFlowDeclareBlock
" jsFlowInterfaceBlock
" jsFlowParenAnnotation
