return (
  <Preview
    onScroll={this.handlePreviewScroll}
    ref={/*...*/}
    dangerouslySetInnerHTML={__html}
  />
  <SourceCodeEditor
    onScroll={this.handleEditorScroll}
    ref={/*...*/}
    onChange={this.handleChange}
    defaultValue={this.state.raw}
  />
);