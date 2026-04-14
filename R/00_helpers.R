# =============================================================================
# policybrief — Helper functions
# =============================================================================

# Convert hex color to lighter version
.lighten_color <- function(hex, amount = 0.85) {
  hex <- gsub("#", "", hex)
  r <- strtoi(substr(hex, 1, 2), 16L)
  g <- strtoi(substr(hex, 3, 4), 16L)
  b <- strtoi(substr(hex, 5, 6), 16L)
  r <- as.integer(r + (255 - r) * amount)
  g <- as.integer(g + (255 - g) * amount)
  b <- as.integer(b + (255 - b) * amount)
  sprintf("#%02x%02x%02x", r, g, b)
}

# Convert hex color to darker version
.darken_color <- function(hex, amount = 0.3) {
  hex <- gsub("#", "", hex)
  r <- as.integer(strtoi(substr(hex, 1, 2), 16L) * (1 - amount))
  g <- as.integer(strtoi(substr(hex, 3, 4), 16L) * (1 - amount))
  b <- as.integer(strtoi(substr(hex, 5, 6), 16L) * (1 - amount))
  sprintf("#%02x%02x%02x", r, g, b)
}

# Encode image file to base64 data URI
.encode_image <- function(path) {
  if (is.null(path) || path == "") return("")
  if (!file.exists(path)) {
    warning("Image not found: ", path)
    return("")
  }
  ext <- tolower(tools::file_ext(path))
  mime <- switch(ext,
    png = "image/png",
    jpg = , jpeg = "image/jpeg",
    gif = "image/gif",
    svg = "image/svg+xml",
    webp = "image/webp",
    "image/png"
  )
  b64 <- base64enc::base64encode(path)
  paste0("data:", mime, ";base64,", b64)
}

# Build an <img> tag from a file path (base64-encoded for portability)
.img_tag <- function(path, alt = "", style = "") {
  if (is.null(path) || path == "") return("")
  uri <- .encode_image(path)
  if (uri == "") return("")
  sprintf('<img src="%s" alt="%s" style="%s">', uri, alt, style)
}

# SVG icons for section headings
.section_icon <- function(icon_name) {
  icons <- list(
    summary = '<svg viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8l-6-6zm-1 1.5L18.5 9H13V3.5zM6 20V4h5v7h7v9H6zm2-7h8v1.5H8V13zm0 3h8v1.5H8V16zm0-6h3v1.5H8V10z"/></svg>',
    context = '<svg viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/></svg>',
    findings = '<svg viewBox="0 0 24 24"><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/></svg>',
    recommendations = '<svg viewBox="0 0 24 24"><path d="M9 21c0 .5.4 1 1 1h4c.6 0 1-.5 1-1v-1H9v1zm3-19C8.1 2 5 5.1 5 9c0 2.4 1.2 4.5 3 5.7V17c0 .5.4 1 1 1h6c.6 0 1-.5 1-1v-2.3c1.8-1.3 3-3.4 3-5.7 0-3.9-3.1-7-7-7z"/></svg>',
    objectives = '<svg viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm0-14c-3.31 0-6 2.69-6 6s2.69 6 6 6 6-2.69 6-6-2.69-6-6-6zm0 10c-2.21 0-4-1.79-4-4s1.79-4 4-4 4 1.79 4 4-1.79 4-4 4zm0-6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"/></svg>',
    results = '<svg viewBox="0 0 24 24"><path d="M16 6l2.29 2.29-4.88 4.88-4-4L2 16.59 3.41 18l6-6 4 4 6.3-6.29L22 12V6h-6z"/></svg>',
    info = '<svg viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-6h2v6zm0-8h-2V7h2v2z"/></svg>',
    default = '<svg viewBox="0 0 24 24"><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-5 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z"/></svg>'
  )
  icon <- icons[[icon_name]]
  if (is.null(icon)) icon <- icons[["default"]]
  icon
}
