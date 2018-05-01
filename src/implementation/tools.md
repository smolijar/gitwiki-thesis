# Used libraries

I have already discussed major, design-defining technologies I plan to use in the section _\hyperref[technologies-and-tools]{Technologies and tools}_ in design chapter.
I held my promise and used each and every tool for stated purpose.

## Source code editor

Apart from the libraries form mentioned section I have used many other existing software.
One of the most notable is Ace editor[@ace], which is utilized in the Emily editor as the underlaying general source code editor, which I used to replace the former CodeMirror[@codemirror] used in the prototype.

Ace editor brought apart from better performance many advantages, from which the most notable one was richer interface for language modes^[Modules allowing to tag phrases in the content, typically for the purpose of syntax highlighting.], which allowed combining more than two modes at once^[CodeMirror allows to define only *mode* and secondary *backdrop mode*, which is used for e.g. spell-check.] ^[Ace provides context switching for modes, which works out of the box (for selecting different highlighters for embedded code in Markdown). While this feature is also available in CodeMirror, only example [@codemirror:mixed] demonstrates it on a XML file, using the `type` attribute to define context.], clearer documentation and native Asciidoc support.

## Libraries for development

For development I used ESLint for coding style control, Babel[@babel] for JS compilation and Webpack[@webpack] for the code bundling. 

## Other libraries

From the remaining notable software in the system's dependencies I used:

- utility libraries Lodash[@lodash]^[in `emily-editor`] and functional JS library Ramda[@ramda]^[in `gitwiki`],
- Ant Design[@antd] React FE library and
- Pino[@pino] for logging.