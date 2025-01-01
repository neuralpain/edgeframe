// standard page margins

#let margin = (
  normal: 2.54cm,
  narrow: 1.27cm,
  moderate-x: 2.54cm,
  moderate-y: 1.91cm,
  wide-x: 5.08cm,
  wide-y: 2.54cm,
  a5-x: 2cm,
  a5-y: 2.5cm,
  a4-x: 2.5cm,
  a4-y: 2cm,
)

#let xlinebreak(size) = {
  linebreak() * size
}

#let xpagebreak(size) = {
  pagebreak() * size
}

// I don't remember why this exists but it does...
// to be lazy is both a blessing and a curse
#let font(body, face: str) = {
  set text(font: face)
  body
}

// Note: headers and footers have a maximum of 3 positions
#let ef-document(
  header: none,
  footer: none,
  set-font: "",
  set-text-size: 11pt,
  set-paper: "us-letter",
  set-margin: margin.normal,
  header-alignment: center,
  footer-alignment: center,
  first-page-header: none,
  last-page-header: none,
  first-page-footer: none,
  last-page-footer: none,
  first-page-header-alignment: center,
  last-page-header-alignment: center,
  first-page-footer-alignment: center,
  last-page-footer-alignment: center,
  page-count: false,
  page-count-position: center,
  watermark: "",
  overlay: none,
  overlay-size: 100%,
  watermark-size: 15em,
  watermark-color: luma(0, 15%),
  watermark-rotation: -45deg,
  hf-flex-layout: true,
  doc,
) = {
  // handle header-footer display
  let hfdata(hf, a) = {
    if hf-flex-layout {
      if type(hf) == "array" and header.len() > 1 {
        if hf.len() == 2 {
          if a == right {
            h(1fr)
            hf.at(0)
            h(1fr)
            hf.at(1)
          } else if a == left {
            hf.at(0)
            h(1fr)
            hf.at(1)
            h(1fr)
          } else {
            hf.at(0)
            h(1fr)
            hf.at(1)
          }
        } else if hf.len() > 2 {
          hf.at(0)
          h(1fr)
          hf.at(1)
          h(1fr)
          hf.at(2)
        } else {
          align(a)[#hf]
        }
      } else {
        align(a)[#hf]
      }
    }
  }

  // set document font styling
  set text(font: set-font, size: set-text-size)

  page(
    paper: set-paper,
    background: rotate(
      watermark-rotation,
      if type(watermark) == "string" {
        text(watermark, size: watermark-size, fill: watermark-color)
      } else { watermark },
    ),
    foreground: scale(overlay, overlay-size),
    margin: set-margin,
    header: context {
      if counter(page).final().last() > 1 {
        // last page
        if last-page-header != none and counter(page).get().at(0) == counter(page).final().at(0) {
          let last-page-header = last-page-header // grab context from outside
          if last-page-header.at(0) == "" or last-page-header.at(0) == none { last-page-header.at(0) = header.at(0) }
          if last-page-header.at(1) == "" or last-page-header.at(1) == none { last-page-header.at(1) = header.at(1) }
          if last-page-header.at(2) == "" or last-page-header.at(2) == none { last-page-header.at(2) = header.at(2) }
          hfdata(last-page-header, last-page-header-alignment)
        } else if counter(page).get().at(0) == counter(page).final().at(0) {
          hfdata(header, header-alignment)
        }
        // first page
        if first-page-header != none and counter(page).get().at(0) == 1 {
          let first-page-header = first-page-header // grab context from outside
          if first-page-header.at(0) == "" or first-page-header.at(0) == none { first-page-header.at(0) = header.at(0) }
          if first-page-header.at(1) == "" or first-page-header.at(1) == none { first-page-header.at(1) = header.at(1) }
          if first-page-header.at(2) == "" or first-page-header.at(2) == none { first-page-header.at(2) = header.at(2) }
          hfdata(first-page-header, first-page-header-alignment)
        } else if counter(page).get().at(0) == 1 {
          hfdata(header, header-alignment)
        }
        // middle
        if counter(page).get().at(0) != 1 and counter(page).get().at(0) != counter(page).final().at(0) {
          hfdata(header, header-alignment)
        }
      } else {
        // single page
        hfdata(header, header-alignment)
      }
    },
    footer: context {
      let footer = footer // grab footer context from outside
      // replace a specific position in the footer with a page counter
      if page-count {
        if type(footer) == "array" {
          if page-count-position == right {
            footer.at(2) = counter(page).display()
          } else if page-count-position == left {
            footer.at(0) = counter(page).display()
          } else {
            footer.at(1) = counter(page).display()
          }
        } else {
          footer = counter(page).display()
        }
      }
      if counter(page).final().last() > 1 {
        // last page
        if last-page-footer != none and counter(page).get().at(0) == counter(page).final().at(0) {
          let last-page-footer = last-page-footer // grab context from outside
          if last-page-footer.at(0) == "" or last-page-footer.at(0) == none { last-page-footer.at(0) = footer.at(0) }
          if last-page-footer.at(1) == "" or last-page-footer.at(1) == none { last-page-footer.at(1) = footer.at(1) }
          if last-page-footer.at(2) == "" or last-page-footer.at(2) == none { last-page-footer.at(2) = footer.at(2) }
          hfdata(last-page-footer, last-page-footer-alignment)
        } else if counter(page).get().at(0) == counter(page).final().at(0) {
          hfdata(footer, footer-alignment)
        }
        // first page
        if first-page-footer != none and counter(page).get().at(0) == 1 {
          let first-page-footer = first-page-footer // grab context from outside
          if first-page-footer.at(0) == "" or first-page-footer.at(0) == none { first-page-footer.at(0) = footer.at(0) }
          if first-page-footer.at(1) == "" or first-page-footer.at(1) == none { first-page-footer.at(1) = footer.at(1) }
          if first-page-footer.at(2) == "" or first-page-footer.at(2) == none { first-page-footer.at(2) = footer.at(2) }
          hfdata(first-page-footer, first-page-footer-alignment)
        } else if counter(page).get().at(0) == 1 {
          hfdata(footer, footer-alignment)
        }
        // middle
        if counter(page).get().at(0) != 1 and counter(page).get().at(0) != counter(page).final().at(0) {
          hfdata(footer, footer-alignment)
        }
      } else {
        // single page
        hfdata(footer, footer-alignment)
      }
    },
    doc,
  )
}
