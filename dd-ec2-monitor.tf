resource "datadog_screenboard" "xander-api-ec2-monitor" {
    title = "Xander's Api "
    read_only = true

    widget {
        type    =   "query_value"
        x       =   1
        y       =   1
        width   =   "${var.dd_widget_width_small}"
        height  =   "${var.dd_widget_height}"
        title       = "Uptime (Without Restart)"
        title_size  = 16
        title_align = "left"

        time = {
            live_span = "1m"
        }

        tile_def {
            viz = "query_value"

            request {

                q       = "max:system.uptime{${var.ec2-api-host-name}}"
                type    = "line"
                aggregator = "max"
            }

            custom_unit = ""
            autoscale   = true
            precision   = "2"

        }
    }

    widget {
        type    =   "query_value"
        x       =   25
        y       =   1
        width   =   "${var.dd_widget_width_small}"
        height  =   "${var.dd_widget_height}"
        title       = "Current CPU Usage /min"
        title_size  = 16
        title_align = "left"

        time = {
            live_span = "1m"
        }

        tile_def {
            viz = "query_value"

            request {

                q       = "max:system.cpu.user{${var.ec2-api-host-name}}"
                type    = "line"
                aggregator = "max"
                
                conditional_format {
                    comparator = ">"
                    value      = "80"
                    palette    = "white_on_red"
                }

                conditional_format {
                    comparator = ">="
                    value      = "60"
                    palette    = "yellow_on_white"
                }

                conditional_format {
                    comparator = "<"
                    value      = "60"
                    palette    = "green_on_white"
                }
            }

            custom_unit = ""
            autoscale   = true
            precision   = "2"

        }
    }

    widget {
        type    =   "query_value"
        x       =   49
        y       =   1
        width   =   "${var.dd_widget_width_small}"
        height  =   "${var.dd_widget_height}"
        title       = "Current Memory Usage /min"
        title_size  = 16
        title_align = "left"

        time = {
            live_span = "1m"
        }

        tile_def {
            viz = "query_value"

            request {

                q       = "max:system.mem.used{${var.ec2-api-host-name}}"
                type    = "line"
                aggregator = "max"
            }

            custom_unit = ""
            autoscale   = true
            precision   = "2"

        }
    }

    widget {
        type    =   "query_value"
        x       =   73
        y       =   1
        width   =   "${var.dd_widget_width_small}"
        height  =   "${var.dd_widget_height}"
        title       = "API Requests Count"
        title_size  = 16
        title_align = "left"

        time = {
            live_span = "global"
        }

        tile_def {
            viz = "query_value"

            request {

                q       = "max:aws.applicationelb.request_count{${var.ecs-api-name}}.as_count()"
                type    = "line"
                aggregator = "max"
            }

            custom_unit = ""
            autoscale   = true
            precision   = "2"

        }
    }

    widget {
        type    =   "timeseries"
        x       =   1
        y       =   17
        width   =   "${var.dd_widget_width_large}"
        height  =   "${var.dd_widget_height}"
        title       = "Total Disk Space"
        title_size  = 16
        title_align = "left"
        legend      = false

        time = {
            live_span = "global"
        }

        tile_def {
            viz = "timeseries"

            request {

                q       = "max:system.disk.total{${var.ec2-api-host-name}}"
                type    = "line"
                style   = {
                    palette     = "dog_classic"
                    line_type   = "solid"
                    line_width  = "normal"
                }
            }

        }
    }

    widget {
        type    =   "timeseries"
        x       =   49
        y       =   17
        width   =   "${var.dd_widget_width_large}"
        height  =   "${var.dd_widget_height}"
        title       = "Free Disk Space"
        title_size  = 16
        title_align = "left"
        legend      = false

        time = {
            live_span = "global"
        }

        tile_def {
            viz = "timeseries"

            request {

                q       = "max:system.disk.free{${var.ec2-api-host-name}}"
                type    = "line"
                style   = {
                    palette     = "dog_classic"
                    line_type   = "solid"
                    line_width  = "normal"
                }
            }

        }
    }

    widget {
        type    =   "timeseries"
        x       =   1
        y       =   33
        width   =   "${var.dd_widget_width_large}"
        height  =   "${var.dd_widget_height}"
        title       = "CPU Usage"
        title_size  = 16
        title_align = "left"
        legend      = false

        time = {
            live_span = "global"
        }

        tile_def {
            viz = "timeseries"

            request {

                q       = "max:system.cpu.system{${var.ec2-api-host-name}}"
                type    = "line"
                style   = {
                    palette     = "dog_classic"
                    line_type   = "solid"
                    line_width  = "normal"
                }
            }

        }
    }

    widget {
        type    =   "timeseries"
        x       =   49
        y       =   33
        width   =   "${var.dd_widget_width_large}"
        height  =   "${var.dd_widget_height}"
        title       = "Memory Usage"
        title_size  = 16
        title_align = "left"
        legend      = false

        time = {
            live_span = "global"
        }

        tile_def {
            viz = "timeseries"

            request {

                q       = "max:system.mem.used{${var.ec2-api-host-name}}"
                type    = "line"
                style   = {
                    palette     = "dog_classic"
                    line_type   = "solid"
                    line_width  = "normal"
                }
            }

        }
    }

    widget {
        type    =   "timeseries"
        x       =   1
        y       =   49
        width   =   95
        height  =   "${var.dd_widget_height}"
        title       = "Network Traffic"
        title_size  = 16
        title_align = "left"
        legend      = false

        time = {
            live_span = "global"
        }

        tile_def {
            viz = "timeseries"

            request {

                q       = "avg:system.net.bytes_sent{${var.ec2-api-host-name}}, avg:system.net.bytes_rcvd{${var.ec2-api-host-name}}"
                type    = "line"
                style   = {
                    palette     = "dog_classic"
                    line_type   = "solid"
                    line_width  = "normal"
                }
            }

        }
    }
}