# Used libraries

The major, design-defining technologies are already mentioned in the section _\hyperref[technologies-and-tools]{Technologies and tools}_ in the design chapter.

Apart from the libraries mentioned however, many other existing software is used for the implementation.

## Source code editor

One of the most notable is Ace editor[@ace], which is utilized in the Emily editor as the underlaying, general purpose source code editor.
It was used to replace the former CodeMirror[@codemirror] used in the prototype, because it was lacking a language mode for AsciiDoc.

Ace editor, apart from better performance, bringss many advantages to the table, from which the most notable one is richer interface for the language modes^[Modules allowing to tag phrases in the content, typically for the purpose of syntax highlighting.], which allowed combining more than two modes at once^[CodeMirror allows to define only *mode* and secondary *backdrop mode*, which is used for e.g. spell-check.] ^[Ace provides context switching for modes, which works out of the box for selecting different highlighters for embedded code in Markdown). While this feature is also available in CodeMirror, the only example [@codemirror:mixed] demonstrates it on a XML file, using the `type` attribute to define context.], clearer documentation and the mentioned native AsciiDoc support^[This is missing in CodeMirror. Custom mode would need to be implemented.].

## Libraries for development

From the development tools, ESLint is used for the coding style control, Babel[@babel] for JS compilation and Webpack [@webpack] for the code bundling.

## Other libraries

From the remaining notable software in the system's dependencies the following is used:

- utility libraries Lodash [@lodash] (in `emily-editor`) and functional JS library Ramda[@ramda] (in `gitwiki`),
- Ant Design [@antd] React FE library and
- Pino [@pino] for logging.
