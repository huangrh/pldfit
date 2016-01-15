

# Subtract baseline of the the same pin in each cycle
pin_baseline_sub <- function(datF = dat, scheme = scheme) {
    # offset to the start and the end of the baseline
    offset = scheme$baseline_offset
    index = datF$index
    prebaseline <- scheme$cycle$prebaseline
    baseline    <- scheme$cycle$baseline

    for (level in (levels(index))) {
        row_idx = (index == level)
        datF_temp = datF[row_idx, ]           # slice the data by the row index
        start = min(datF_temp$Time) + prebaseline + offset
        end = start + baseline - 2 * offset
        # further slice the data to just keep the baseline portion.
        datF_temp =  dplyr::filter(datF[row_idx, ], Time > start, Time < end)

        for (col_idx in (setdiff(names(datF), c("Time", "index"))) ) {
            baseline_mean = mean(datF_temp[[col_idx]]);
            datF[row_idx, col_idx] <- datF[row_idx, col_idx] - baseline_mean
        }
    }

    return(datF)
}

# function to subtract the baseline from a control pin
contr_baseline_sub <- function(datF = dat, control = dat$control) {
    # control from a control pin, which usually under
    contr_baseline = control

    # baseline subtraction
    for (idx in (setdiff(names(datF), c("Time", "index")))) {
        datF[idx] <- datF[idx] - contr_baseline
    }

    # combine and return the baseline corrected
    return(datF)
}

