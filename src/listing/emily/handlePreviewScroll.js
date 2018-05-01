handlePreviewScroll = () => {
  if (this.lastScrolled === 'editor') {
    this.lastScrolled = null;
    return;
  }
  const firstVisibleLine = this.getPreviewFirstVisibleLine();
  const deltaPositive = firstVisibleLine > this.ace.renderer.getFirstVisibleRow() + 1;

  // dont scroll editor if preview scroll "out of source" (e.g. footnotes)
  if (this.ace.renderer.isScrollableBy(null, deltaPositive ? 1 : -1)) {
    this.lastScrolled = 'preview';
    this.scrollEditorToLine(firstVisibleLine);
  }
}