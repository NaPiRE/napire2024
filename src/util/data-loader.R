library(tidyverse)
library(readxl)

cat.likert <- c("Strongly disagree", "Disagree", "No opinion", "Agree", "Strongly Agree")
cat.good <- c("Very good", "Good", "Neutral", "Bad", "Very bad")

load_country_codes <- function(data_path) {
  country.codes.iso <- read.csv(file = file.path(data_path, 'iso-3166-1a2.csv'))
  country.codes.napire <- read_excel(file.path(data_path, "country-codes.xlsx"))
  country.codes <- 
    left_join(country.codes.napire, country.codes.iso, by = "Country") %>% 
    rename(v_23 = "Code") %>% 
    mutate(v_23 = as.integer(v_23))
  
  return(country.codes)
}

load_problems <- function(data_path) {
  problems <- read_excel(file.path(data_path, "problem-categories.xlsx"))
  
  return(problems)
}

#' Load the data from the 2024 run of NaPiRE and prepare all variables
#' 
#' @param file Location of the data set
#' @returns The NaPiRE data set from the 2024 run
load_data_2024 <- function(data_path, file) {
  na.values <- c("-66", "-77")
  
  # load the cleaned data set
  d <- read.csv(file = file.path(data_path, file), 
                    header=TRUE, skip=1, sep=";", na.strings=na.values)
  
  # remove unnecessary columns
  d <- d %>% 
    select(-quality)
  
  # load the specification of "problems"
  problems <- load_problems(data_path) %>% 
    mutate(N24c = as.integer(N24c)) %>% 
    select(Problem, N24, N24c) %>% 
    filter(!(N24 == "-")) %>% 
    arrange(N24c)
  
  # cast variables into their appropriate form
  d <- d %>% 
    mutate(
      # main industrial sector of the project
      v_1 = factor(v_1,
                   levels = c(1:10, 12:23), # label 11 is not assigned 
                   labels = c("Agriculture", "Automotive", "Finance", "Healthcare",
                              "Security", "Manufacturing", "Energy", "Logistics",
                              "Railway", "Avionics", "Insurance", "Education",
                              "Public sector", "Enterprise resource planning",
                              "Human resources", "e-Government", "Telecommunication", 
                              "Games engineering", "Public transportation", 
                              "e-Commerce", "Other", "Aerospace"), 
                   ordered = FALSE),
      # team distribution
      v_16 = factor(v_16, levels = 1:3, labels = c("Yes", "No", "I don't know")),
      # main role respondent
      v_17 = factor(v_17, levels = 1:12, 
                    labels = c("Business Analyst", "Customer", "Developer",
                               "Project Lead / Project Manager", "Product Owner",
                               "Product Manager", "Scrum Master", "Architect",
                               "Test Manager / Tester", "Marketing", 
                               "Requirements Engineer", "Other"), 
                    ordered = FALSE),
      # characterization relationship customer
      v_25 = factor(v_25, levels = 1:5, labels = cat.good, ordered = TRUE),
      # elicitation: agile in several iterations
      v_28 = (v_28 == 1),
      # elicitation: waterfall in a dedicated phase
      v_29 = (v_29 == 1),
      # elicitation: other
      v_34 = (v_34 == 1),
      # elicitation technique: interviews
      v_36 = (v_36 == 1),
      # elicitation technique: document analysis
      v_37 = (v_37 == 1),
      # elicitation technique: risk analyses
      v_38 = (v_38 == 1),
      # elicitation technique: prototyping
      v_39 = (v_39 == 1),
      # elicitation technique: workshop and focus group
      v_40 = (v_40 == 1),
      # elicitation technique: reuse
      v_41 = (v_41 == 1),
      # elicitation technique: design thinking
      v_42 = (v_42 == 1),
      # elicitation technique: external experts
      v_43 = (v_43 == 1),
      # elicitation technique: observations
      v_44 = (v_44 == 1),
      # elicitation technique: other
      v_45 = (v_45 == 1),
      # elicitation technique: outsourcing
      v_47 = (v_47 == 1),
      # documentation: functional properties of the system
      v_68 = (v_68 == 1),
      # documentation: usage scenarios
      v_69 = (v_69 == 1),
      # documentation: goals
      v_70 = (v_70 == 1),
      # documentation: quality properties of the system
      v_71 = (v_71 == 1),
      # documentation: user interfaces
      v_72 = (v_72 == 1),
      # documentation: development process aspects
      v_73 = (v_73 == 1),
      # documentation: rules
      v_74 = (v_74 == 1),
      # documentation: technical interfaces
      v_75 = (v_75 == 1),
      # documentation: architectural constraints
      v_76 = (v_76 == 1),
      # documentation: system behavior
      v_77 = (v_77 == 1),
      # documentation: stakeholders
      v_78 = (v_78 == 1),
      # documentation: formal properties of the system
      v_79 = (v_79 == 1),
      # documentation: other
      v_80 = (v_80 == 1),
      # documentation type: use cases
      v_82 = (v_82 == 1),
      # documentation type: natural language text
      v_83 = (v_83 == 1),
      # documentation type: structured lists of requirements
      v_84 = (v_84 == 1),
      # documentation type: user stories
      v_85 = (v_85 == 1),
      # documentation type: use case diagrams
      v_86 = (v_86 == 1),
      # documentation type: activity diagrams
      v_87 = (v_87 == 1),
      # documentation type: class diagrams
      v_88 = (v_88 == 1),
      # documentation type: sequence diagrams
      v_89 = (v_89 == 1),
      # documentation type: state machines
      v_90 = (v_90 == 1),
      # documentation type: goal models
      v_91 = (v_91 == 1),
      # documentation type: business process models
      v_92 = (v_92 == 1),
      # documentation type: prototypes
      v_93 = (v_93 == 1),
      # documentation type: other
      v_95 = (v_95 == 1),
      # nfrs: compatibility
      v_97 = (v_97 == 1),
      # nfrs: maintainability
      v_98 = (v_98 == 1),
      # nfrs: performance efficiency
      v_99 = (v_99 == 1),
      # nfrs: portability
      v_100 = (v_100 == 1),
      # nfrs: reliability
      v_101 = (v_101 == 1),
      # nfrs: safety
      v_102 = (v_102 == 1),
      # nfrs: usability
      v_103 = (v_103 == 1),
      # nfrs: other
      v_104 = (v_104 == 1),
      # requirements validation: testers participate
      v_158 = (v_158 == 1),
      # requirements validation: check coverage
      v_159 = (v_159 == 1),
      # requirements validation: define acceptance criteria
      v_160 = (v_160 == 1),
      # requirements validation: derive tests from system models
      v_161 = (v_161 == 1),
      # requirements validation: no alignment
      v_162 = (v_162 == 1),
      # requirements validation: other
      v_163 = (v_163 == 1),
      # nfrs: security
      v_303 = (v_303 == 1),
      # project team distribution
      v_357 = (v_357 == 1), # 1 = Yes, 2 = No
      # Intra-team coordination
      v_359 = factor(v_359, levels = 1:5, labels = cat.good, ordered = TRUE),
      # user feedback frequency
      v_368 = factor(v_368, levels = c(1:3,5:8), 
                     labels = c("Almost daily", "Weekly", "Bi-weekly",
                                "Monthly", "Never", "I don't know", "Other"), 
                     ordered = TRUE),
      # degree of virtualization
      v_377 = factor(v_377, levels = c(1, 2, 3, 5, 6, 4),
                     labels = c("Almost completely on-site", "Mostly on-site",
                                "Approximately half on-site and half from home",
                                "Mostly from home", "Almost completely from home",
                                "Other"),
                     ordered = TRUE),
      # communication frequency
      v_380 = factor(v_380, 
                     #levels = c(10, 1, 9, 2, 3, 6, 11, 13, 12, 8),
                     #labels = c("Daily", "Almost daily", "Twice per week", 
                     #            "Weekly", "Bi-weekly", "Monthly", "Bi-monthly", 
                     #            "Quarterly", "Rarely", "I don't know"),
                     levels = c(1, 2, 3, 6, 7, 8),
                     labels = c("Almost daily", "Weekly", "Bi-weekly", 
                                "Monthly", "I don't know", "Other"),
                     ordered = TRUE),
      # problems: communication flaws within our project team
      v_385 = factor(v_385, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: communication flaws between project and customer
      v_386 = factor(v_386, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: lack of commitment to goals
      v_387 = factor(v_387, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: incomplete or hidden requirements
      v_388 = factor(v_388, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: insufficient support by project lead
      v_389 = factor(v_389, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: inconsistent requirements
      v_392 = factor(v_392, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: requirements not traceable
      v_393 = factor(v_393, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: moving targets
      v_394 = factor(v_394, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: gold plating
      v_395 = factor(v_395, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: weak access to customers
      v_396 = factor(v_396, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: weak knowledge about customer's application domain
      v_397 = factor(v_397, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: not enough time
      v_399 = factor(v_399, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: technically unfeasible requirements
      v_401 = factor(v_401, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: underspecified requirements
      v_402 = factor(v_402, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: unclear or unmeasurable NFRs
      v_403 = factor(v_403, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: lack of trust within team
      v_404 = factor(v_404, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: non-represented stakeholder
      v_405 = factor(v_405, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: language barriers
      v_406 = factor(v_406, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: terminology
      v_407 = factor(v_407, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: unclear responsibilities
      v_408 = factor(v_408, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: ineffective communication channels
      v_409 = factor(v_409, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: requirements change are not communicated
      v_410 = factor(v_410, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: lack of trust between our project team members and stakeholder or customer.
      v_411 = factor(v_411, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: no standard format for documentation
      v_417 = factor(v_417, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: lack of communication between project and user
      v_418 = factor(v_418, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # nfrs: constraints
      v_422 = (v_422 == 1),
      # inter-team communication
      v_452 = factor(v_452, levels = 1:5, labels = cat.good, ordered = TRUE),
      # elicitation technique: none
      v_454 = (v_454 == 1),
      # assumptions situation
      v_455 = factor(v_455, levels = 1:4, 
                     labels = c("Make a reasonable assumption myself and proceed.",
                                "Ask the customer, end user, or both what should be assumed before proceeding.",
                                "I do not know.",
                                "Does not apply.")),
      # way of working
      v_457 = factor(v_457, levels = 1:6, 
                     labels = c("Agile", "Rather agile", "Hybrid", "Rather plan-driven", 
                                "Plan-driven", "I don't know"),
                     ordered = TRUE),
      # problems: RErs lack enthusiasm
      v_459 = factor(v_459, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # elicitation technique: don't know
      v_461 = (v_461 == 1),
      # documentation type: acceptance criteria
      v_463 = (v_463 == 1),
      # documentation: constraints
      v_466 = (v_466 == 1),
      # producing documents willingly
      v_482 = factor(v_482, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # producing documents anyway
      v_484 = factor(v_484, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # not producing
      v_487 = factor(v_487, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # documentation: acceptance criteria
      v_557 = (v_557 == 1),
      # documentation type: informal sketches
      v_558 = (v_558 == 1),
      # reasons to stop requirements analysis: project terminated
      v_559 = factor(v_559, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # reasons to stop requirements analysis: scheduled end
      v_560 = factor(v_560, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # reasons to stop requirements analysis: project leader decided spent enough time
      v_561 = factor(v_561, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # reasons to stop requirements analysis: project leader decided wasted enough time
      v_562 = factor(v_562, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # reasons to stop requirements analysis: project leader decided start now
      v_563 = factor(v_563, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # reasons to stop requirements analysis: team decided spent enough time
      v_564 = factor(v_564, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # reasons to stop requirements analysis: team decided wasted enough time
      v_565 = factor(v_565, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # reasons to stop requirements analysis: team decided to start now
      v_566 = factor(v_566, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # reasons to stop requirements analysis: itching to start implementing
      v_567 = factor(v_567, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # reasons to stop requirements analysis: wasted enough time
      v_568 = factor(v_568, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # reasons to stop requirements analysis: time to start
      v_569 = factor(v_569, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # problems: constraints not considered
      v_571 = factor(v_571, levels = 1:5, labels = cat.likert, ordered = TRUE),
      # elicitation: don't know
      v_572 = (v_572 == 1),
      # requirements validation: don't know
      v_573 = (v_573 == 1),
      # requirements validation: does not apply
      v_574 = (v_574 == 1),
      # documentation type: don't know
      v_575 = (v_575 == 1),
      # documentation: don't know
      v_576 = (v_576 == 1),
      # failed to document
      v_577 = factor(v_577, levels = 1:3, labels = c("Yes", "No", 
                                                     "I do not document requirements")),
      # critical problems: top 1
      v_661 = factor(v_246, levels = 1:27, labels = problems$Problem, ordered = FALSE),
      # critical problems: top 2
      v_662 = factor(v_248, levels = 1:27, labels = problems$Problem, ordered = FALSE),
      # critical problems: top 3
      v_663 = factor(v_250, levels = 1:27, labels = problems$Problem, ordered = FALSE),
      # critical problems: top 4
      v_664 = factor(v_252, levels = 1:27, labels = problems$Problem, ordered = FALSE),
      # critical problems: top 5
      v_665 = factor(v_254, levels = 1:27, labels = problems$Problem, ordered = FALSE),
      # elicitation technique: usage data analysis
      v_667 = (v_667 == 1),
      # elicitation technique: lean startup
      v_668 = (v_668 == 1),
      # elicitation technique: experimentation with users
      v_669 = (v_669 == 1),
      # failing to document: no need
      v_670 = (v_670 == 1),
      # failing to document: complain/ridicule
      v_671 = (v_671 == 1),
      # failing to document: project lead told not to bother
      v_672 = (v_672 == 1),
      # failing to document: project lead told not to spend time
      v_673 = (v_673 == 1),
      # failing to document: project lead told not to waste time
      v_674 = (v_674 == 1),
      # failing to document: colleagues told not to bother
      v_675 = (v_675 == 1),
      # failing to document: colleagues told not to spend time
      v_676 = (v_676 == 1),
      # failing to document: colleagues told not to waste time
      v_677 = (v_677 == 1),
    )
  
  # add country name and ISO 3166-1 alpha-2 codes
  country.codes <- load_country_codes(data_path)
  d <- left_join(d, country.codes, by = "v_23")
  
  return(d)
}
