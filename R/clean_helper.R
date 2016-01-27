`%notin%` <- Negate(`%in%`)

# strip rows at the end of association, representing the steady state.
strip_rows <- function(datF = dat, scheme = scheme) {
    start_ = scheme$steady_state$start
    end_   = scheme$steady_state$end
    index = datF$index
    prebaseline <- scheme$cycle$prebaseline
    baseline    <- scheme$cycle$baseline
    datF_out = data.frame()
    for (level in levels(index)) {
        row_idx = index == level
        datF_temp = datF[row_idx, ]
        start = min(datF_temp$Time) + prebaseline + baseline + scheme$steady_state$start
        end = start + scheme$steady_state$end - scheme$steady_state$start
        datF_temp = dplyr::filter(datF[row_idx, ], Time > start, Time < end)
        datF_out = rbind(datF_out, datF_temp)
    }
    # datF_out$index = with(datF_out, factor(index, levels = rev(levels(index))))

    return(datF_out)
}

# calculate the mean of the stripped rows.
# As such, the input data frame should be returned from the function strip_rows.
strip_mean <- function(datF = data.frame(), scheme = scheme) {
    index = datF$index
    datF_mean = data.frame()
    # datF_std = data.frame()

    for (level in levels(index)) {
        row_idx = index == level
        datF_temp = datF[row_idx, ]

        for (col_idx in (setdiff(names(datF), c("Time", "index"))) ) {
            datF_mean[level, col_idx] = mean(unlist(datF[row_idx, col_idx]))

        }
    }
    datF_mean$index = as.factor(rownames(datF_mean))
    datF_mean$index = with(datF_mean, factor(index, levels = rev(levels(index))))

    return(datF_mean)
}

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

