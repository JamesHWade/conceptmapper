Tests and Coverage
================
31 January, 2022 20:49:22

-   [Coverage](#coverage)
-   [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                              | Coverage (%) |
|:----------------------------------------------------|:------------:|
| conceptmapper                                       |     8.81     |
| [R/golem_utils_server.R](../R/golem_utils_server.R) |     0.00     |
| [R/golem_utils_ui.R](../R/golem_utils_ui.R)         |     0.00     |
| [R/mod_build_links.R](../R/mod_build_links.R)       |     0.00     |
| [R/mod_build_nodes.R](../R/mod_build_nodes.R)       |     0.00     |
| [R/run_app.R](../R/run_app.R)                       |     0.00     |
| [R/app_config.R](../R/app_config.R)                 |    14.29     |
| [R/app_ui.R](../R/app_ui.R)                         |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                                          |   n |  time | error | failed | skipped | warning | icon |
|:--------------------------------------------------------------|----:|------:|------:|-------:|--------:|--------:|:-----|
| [test-app.R](testthat/test-app.R)                             |   1 | 0.025 |     0 |      0 |       0 |       0 |      |
| [test-golem-recommended.R](testthat/test-golem-recommended.R) |   8 | 0.045 |     0 |      0 |       1 |       1 | 🔶⚠️ |

<details open>
<summary>
Show Detailed Test Results
</summary>

| file                                                              | context           | test                 | status  |   n |  time | icon |
|:------------------------------------------------------------------|:------------------|:---------------------|:--------|----:|------:|:-----|
| [test-app.R](testthat/test-app.R#L2)                              | app               | multiplication works | PASS    |   1 | 0.025 |      |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L3)  | golem-recommended | app ui               | PASS    |   2 | 0.033 |      |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L13) | golem-recommended | app server           | WARNING |   5 | 0.011 | ⚠️   |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L24) | golem-recommended | app launches         | SKIPPED |   1 | 0.001 | 🔶   |

| Failed | Warning | Skipped |
|:-------|:--------|:--------|
| 🛑     | ⚠️      | 🔶      |

</details>
<details>
<summary>
Session Info
</summary>

| Field    | Value                            |
|:---------|:---------------------------------|
| Version  | R version 4.1.2 (2021-11-01)     |
| Platform | x86_64-apple-darwin17.0 (64-bit) |
| Running  | macOS Monterey 12.1              |
| Language | en_US                            |
| Timezone | America/Detroit                  |

| Package  | Version |
|:---------|:--------|
| testthat | 3.1.0   |
| covr     | 3.5.1   |
| covrpage | 0.1     |

</details>
<!--- Final Status : skipped/warning --->
