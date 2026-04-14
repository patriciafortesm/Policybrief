# =============================================================================
# policybrief — Main assembly function
# =============================================================================

#' Generate a complete policy brief as an HTML file
#'
#' Assembles cover, about, content sections, and back cover into a single
#' standalone HTML file ready to share or print.
#'
#' @param pages A list of page HTML strings, created by \code{pb_cover()},
#'   \code{pb_about()}, \code{pb_section()}, and \code{pb_back_cover()}.
#' @param output Path to the output HTML file. Default: "policy_brief.html".
#' @param title Document title (for the HTML <title> tag).
#' @param primary_color Primary color as hex (e.g., "#00838F"). Used for headings,
#'   bars, icons, highlights. Default: teal.
#' @param accent_color Accent color as hex (e.g., "#FF6F00"). Used for subtitles,
#'   finding borders, callouts. Default: orange.
#' @param lang Language code for the HTML lang attribute. Default: "en".
#' @param open Logical. Open the file in the browser after creation? Default: TRUE.
#'
#' @return Invisible path to the generated file.
#' @export
#'
#' @examples
#' \dontrun{
#' policy_brief(
#'   title = "Education in Crisis Regions",
#'   primary_color = "#00838F",
#'   accent_color = "#FF6F00",
#'   pages = list(
#'
#'     pb_cover(
#'       title = "Education Cannot Wait",
#'       subtitle = "Annual Results Report 2024",
#'       cover_image = "photo.jpg",
#'       logo = "logo.png"
#'     ),
#'
#'     pb_about(
#'       text = c(
#'         "This report was prepared by the ECW Secretariat.",
#'         "Opinions expressed are those of the authors."
#'       ),
#'       institution_name = "Education Cannot Wait",
#'       institution_description = "The global fund for education in emergencies."
#'     ),
#'
#'     pb_section(
#'       title = "Executive Summary",
#'       icon = "summary",
#'       content = c(
#'         "Investments in education for children affected by emergencies...",
#'         "In 2024, ECW supported 3.7 million children across 32 countries."
#'       ),
#'       highlight = "222 million school-age children are affected by crisis worldwide."
#'     ),
#'
#'     pb_section(
#'       title = "Key Findings",
#'       icon = "findings",
#'       stats = list("Children reached" = "3.7M", "Countries" = "32", "Grants" = "174"),
#'       findings = list(
#'         "Access improved" = "96% of programs reported improved access to education.",
#'         "Gender parity" = "92% of programs showed improved gender parity."
#'       )
#'     ),
#'
#'     pb_section(
#'       title = "Recommendations",
#'       icon = "recommendations",
#'       recommendations = c(
#'         "Increase funding for education in emergencies by 50%.",
#'         "Prioritize girls' education and disability inclusion.",
#'         "Strengthen data systems for learning outcome measurement."
#'       )
#'     ),
#'
#'     pb_back_cover(
#'       institution_name = "Education Cannot Wait",
#'       website = "https://www.educationcannotwait.org",
#'       email = "info@un-ecw.org",
#'       logo = "logo.png"
#'     )
#'   )
#' )
#' }
policy_brief <- function(pages,
                         output = "policy_brief.html",
                         title = "Policy Brief",
                         primary_color = "#00838F",
                         accent_color = "#FF6F00",
                         lang = "en",
                         open = TRUE) {

  # Read template
  template_path <- system.file("template", "template.html", package = "policybrief")
  if (template_path == "") {
    # Fallback: look in development path
    template_path <- file.path(getwd(), "inst", "template", "template.html")
  }
  if (!file.exists(template_path)) {
    stop("Template not found. Is the policybrief package installed correctly?")
  }

  template <- paste(readLines(template_path, encoding = "UTF-8"), collapse = "\n")

  # Compute color variants
  primary_light <- .lighten_color(primary_color, 0.88)
  primary_dark  <- .darken_color(primary_color, 0.25)

  # Assemble page content
  content <- paste(pages, collapse = "\n\n")

  # Replace placeholders
  html <- template
  html <- gsub("{{TITLE}}", title, html, fixed = TRUE)
  html <- gsub("{{LANG}}", lang, html, fixed = TRUE)
  html <- gsub("{{PRIMARY_COLOR}}", primary_color, html, fixed = TRUE)
  html <- gsub("{{PRIMARY_LIGHT}}", primary_light, html, fixed = TRUE)
  html <- gsub("{{PRIMARY_DARK}}", primary_dark, html, fixed = TRUE)
  html <- gsub("{{ACCENT_COLOR}}", accent_color, html, fixed = TRUE)
  html <- gsub("{{CONTENT}}", content, html, fixed = TRUE)

  # Write output
  writeLines(html, output, useBytes = TRUE)
  message("[policybrief] Policy brief saved: ", output)

  # Open in browser
  if (open) {
    utils::browseURL(output)
  }

  invisible(output)
}
