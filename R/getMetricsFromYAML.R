#' Get Metrics from YAML
#'
#' Parse the summary YAML and return quality control metrics.
#'
#' @note Metrics are only generated for a standard RNA-seq run with aligned
#'   counts. Fast RNA-seq mode with lightweight counts (pseudocounts) doesn't
#'   output the same metrics into the YAML.
#'
#' @author Michael Steinbaugh
#' @inheritParams basejump::params
#' @inheritParams params
#' @export
#'
#' @return `DataFrame`.
#'
#' @examples
#' file <- file.path(bcbioBaseCacheURL, "summary.yaml")
#' yaml <- import(file)
#' x <- getMetricsFromYAML(yaml)
#' summary(x)
#' colnames(x)
getMetricsFromYAML <- function(yaml) {
    message("Getting sample metrics from YAML.")
    data <- .sampleYAML(yaml, keys = c("summary", "metrics"))

    # Early return on empty metrics (e.g. fast mode).
    if (!has_length(data)) {
        # nocov start
        message("No metrics were calculated.")
        return(NULL)
        # nocov end
    }

    # Drop any metadata columns. Note we're also dropping the duplicate `name`
    # column present in the metrics YAML.
    yamlFlatCols <- c("description", "genome_build", "sam_ref")
    blacklist <- c(camel(yamlFlatCols), "name")
    data <- data %>%
        as_tibble(rownames = "rowname") %>%
        # Drop blacklisted columns from the return.
        .[, sort(setdiff(colnames(.), blacklist)), drop = FALSE] %>%
        # Convert all strings to factors.
        mutate_if(is.character, as.factor) %>%
        mutate_if(is.factor, droplevels) %>%
        as("DataFrame")
    assertHasRownames(data)
    data
}