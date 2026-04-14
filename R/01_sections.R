# =============================================================================
# policybrief — Section builder functions
# =============================================================================

#' Create a cover page
#'
#' @param title Main title of the policy brief (large text).
#' @param subtitle Subtitle or tagline (smaller, accent color).
#' @param doc_type Document type label (e.g., "Executive Summary", "Policy Brief").
#' @param cover_image Path to the cover image file.
#' @param logo Path to the institution logo file.
#'
#' @return HTML string for the cover page.
#' @export
pb_cover <- function(title, subtitle = "", doc_type = "POLICY BRIEF",
                     cover_image = NULL, logo = NULL) {
  logo_html <- if (!is.null(logo) && logo != "") {
    paste0('<div class="cover-logo">', .img_tag(logo, "Logo"), '</div>')
  } else ""

  image_html <- if (!is.null(cover_image) && cover_image != "") {
    paste0('<div class="cover-image-container">', .img_tag(cover_image, "Cover"), '</div>')
  } else '<div class="cover-image-container"></div>'

  paste0(
    '<div class="page cover">\n',
    '  <div class="cover-top-bar">\n',
    '    ', logo_html, '\n',
    '    <div class="cover-doc-type">', doc_type, '</div>\n',
    '  </div>\n',
    '  ', image_html, '\n',
    '  <div class="cover-title-block">\n',
    '    <div class="cover-subtitle">', doc_type, '</div>\n',
    '    <div class="cover-title">', title, '</div>\n',
    if (subtitle != "") paste0('    <div class="cover-tagline">', subtitle, '</div>\n') else "",
    '  </div>\n',
    '</div>\n'
  )
}

#' Create the About page
#'
#' @param text Main about text (can be multiple paragraphs as a character vector).
#' @param about_title Title for the about page. Default: "About this publication".
#'   Use this to set the language, e.g. "Sobre esta publicacao" (Portuguese),
#'   "Acerca de esta publicacion" (Spanish), "A propos" (French).
#' @param institution_name Name of the institution.
#' @param institution_description Short description of the institution.
#' @param license_text Optional license/disclaimer text.
#'
#' @return HTML string for the about page.
#' @export
pb_about <- function(text, about_title = "About this publication",
                     institution_name = "", institution_description = "",
                     license_text = "") {
  paras <- paste(sapply(text, function(p) paste0("<p>", p, "</p>")), collapse = "\n")

  inst_html <- ""
  if (institution_name != "") {
    inst_html <- paste0(
      '<div class="about-institution">\n',
      '  <h3>', institution_name, '</h3>\n',
      '  <p>', institution_description, '</p>\n',
      '</div>\n'
    )
  }

  license_html <- ""
  if (license_text != "") {
    license_html <- paste0('<p style="font-size:12px; margin-top:20px; color:#888;">', license_text, '</p>')
  }

  paste0(
    '<div class="page about-page">\n',
    '  <h2>', about_title, '</h2>\n',
    '  ', paras, '\n',
    '  ', inst_html, '\n',
    '  ', license_html, '\n',
    '</div>\n'
  )
}

#' Create a content section (one page)
#'
#' @param title Section title.
#' @param subtitle Optional subtitle.
#' @param content Character vector of paragraphs or raw HTML.
#' @param icon Icon name: "summary", "context", "findings", "recommendations",
#'   "objectives", "results", "info", or "default".
#' @param highlight Optional highlight box text.
#' @param highlight_style Style: "primary" (default), "accent", or "outline".
#' @param image Path to an image file to include.
#' @param image_caption Caption for the image.
#' @param findings Named list for findings cards (name = title, value = text).
#' @param stats Named list for stat callouts (name = label, value = number).
#' @param recommendations Character vector of recommendation texts.
#' @param two_columns Logical. Use two-column layout for text? Default FALSE.
#' @param footnotes Character vector of footnotes.
#' @param logo Path to header logo (small, top-right).
#' @param raw_html Raw HTML to append at the end of the section.
#'
#' @return HTML string for a content page.
#' @export
pb_section <- function(title, subtitle = "", content = NULL,
                       icon = "default", highlight = NULL,
                       highlight_style = "primary",
                       image = NULL, image_caption = "",
                       findings = NULL, stats = NULL,
                       recommendations = NULL,
                       two_columns = FALSE, footnotes = NULL,
                       logo = NULL, raw_html = NULL) {

  # Page header
  header_logo <- if (!is.null(logo) && logo != "") {
    paste0('<div class="page-header-logo">', .img_tag(logo, "Logo"), '</div>')
  } else ""

  header <- paste0(
    '<div class="page-header">\n',
    '  <div class="page-header-title">', title, '</div>\n',
    '  ', header_logo, '\n',
    '</div>\n'
  )

  # Section heading with icon
  heading <- paste0(
    '<div class="section-heading">\n',
    '  <div class="icon-bar">', .section_icon(icon), '</div>\n',
    '  <h2>', title, '</h2>\n',
    if (subtitle != "") paste0('  <div class="heading-subtitle">', subtitle, '</div>\n') else "",
    '</div>\n'
  )

  # Body text
  col_class <- if (two_columns) ' two-columns' else ''
  text_html <- ""
  if (!is.null(content)) {
    text_html <- paste(sapply(content, function(p) {
      # If it starts with <, treat as raw HTML
      if (grepl("^\\s*<", p)) return(p)
      paste0('<p class="body-text', col_class, '">', p, '</p>')
    }), collapse = "\n")
  }

  # Highlight box
  hl_html <- ""
  if (!is.null(highlight)) {
    hl_class <- switch(highlight_style,
      accent = " accent",
      outline = " outline",
      ""
    )
    hl_html <- paste0('<div class="highlight-box', hl_class, '">', highlight, '</div>\n')
  }

  # Stats
  stats_html <- ""
  if (!is.null(stats)) {
    cards <- paste(mapply(function(label, number) {
      paste0(
        '<div class="stat-card">\n',
        '  <div class="number">', number, '</div>\n',
        '  <div class="label">', label, '</div>\n',
        '</div>'
      )
    }, names(stats), stats, SIMPLIFY = FALSE), collapse = "\n")
    stats_html <- paste0('<div class="stat-row">\n', cards, '\n</div>\n')
  }

  # Findings grid
  findings_html <- ""
  if (!is.null(findings)) {
    cards <- paste(mapply(function(ftitle, ftext) {
      paste0(
        '<div class="finding-card">\n',
        '  <h4>', ftitle, '</h4>\n',
        '  <p>', ftext, '</p>\n',
        '</div>'
      )
    }, names(findings), findings, SIMPLIFY = FALSE), collapse = "\n")
    findings_html <- paste0('<div class="findings-grid">\n', cards, '\n</div>\n')
  }

  # Recommendations
  rec_html <- ""
  if (!is.null(recommendations)) {
    items <- paste(mapply(function(text, i) {
      paste0(
        '<li>\n',
        '  <div class="rec-number">', i, '</div>\n',
        '  <div class="rec-text">', text, '</div>\n',
        '</li>'
      )
    }, recommendations, seq_along(recommendations), SIMPLIFY = FALSE), collapse = "\n")
    rec_html <- paste0('<ul class="rec-list">\n', items, '\n</ul>\n')
  }

  # Image
  img_html <- ""
  if (!is.null(image) && image != "") {
    img_html <- paste0(
      '<div class="figure-container">\n',
      '  ', .img_tag(image, image_caption), '\n',
      if (image_caption != "") paste0('  <div class="caption">', image_caption, '</div>\n') else "",
      '</div>\n'
    )
  }

  # Raw HTML
  raw <- ""
  if (!is.null(raw_html)) {
    raw <- paste0('<div class="custom-section">', raw_html, '</div>\n')
  }

  # Footnotes
  fn_html <- ""
  if (!is.null(footnotes)) {
    fn_items <- paste(sapply(seq_along(footnotes), function(i) {
      paste0("<sup>", i, "</sup> ", footnotes[i])
    }), collapse = "<br>")
    fn_html <- paste0('<div class="footnotes">', fn_items, '</div>\n')
  }

  paste0(
    '<div class="page content-page">\n',
    header,
    heading,
    text_html, '\n',
    hl_html,
    stats_html,
    findings_html,
    rec_html,
    img_html,
    raw, '\n',
    fn_html,
    '</div>\n'
  )
}

#' Create the back cover page
#'
#' @param institution_name Name of the institution.
#' @param website Website URL.
#' @param email Contact email.
#' @param social Social media handle(s).
#' @param logo Path to logo (displayed in white/light version).
#' @param extra_text Additional text (e.g., follow us).
#'
#' @return HTML string for the back cover.
#' @export
pb_back_cover <- function(institution_name = "", website = "", email = "",
                          social = "", logo = NULL, extra_text = "") {
  logo_html <- if (!is.null(logo) && logo != "") {
    paste0('<div class="back-logo">', .img_tag(logo, "Logo"), '</div>')
  } else ""

  contact_lines <- c()
  if (website != "") contact_lines <- c(contact_lines, paste0('<a href="', website, '">', website, '</a>'))
  if (email != "") contact_lines <- c(contact_lines, paste0('<a href="mailto:', email, '">', email, '</a>'))
  contact_html <- paste(contact_lines, collapse = "<br>")

  paste0(
    '<div class="page back-cover">\n',
    '  ', logo_html, '\n',
    '  <h3>', institution_name, '</h3>\n',
    if (extra_text != "") paste0('  <p style="max-width:500px;line-height:1.8;opacity:0.85;margin-bottom:20px;">', extra_text, '</p>\n') else "",
    '  <div class="contact-info">', contact_html, '</div>\n',
    if (social != "") paste0('  <div class="social-handle">', social, '</div>\n') else "",
    '</div>\n'
  )
}
