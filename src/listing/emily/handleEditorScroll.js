handleEditorScroll = () => {
  if (this.lastScrolled === 'preview') {
    this.lastScrolled = null;
    return;
  }
  this.lastScrolled = 'editor';
  this.ace.renderer.$computeLayerConfig();
  const firstVisibleLine = this.ace.renderer.getFirstVisibleRow() + 1;
  this.scrollPreviewToLine(firstVisibleLine);
}