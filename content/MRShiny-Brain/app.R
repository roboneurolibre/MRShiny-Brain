### MRShiny Brain

# Load packages
library(shiny)
library(shinythemes)
library(RNifti)
library(ggExtra)
library(plotly)
library(devtools)
library(dplyr)
library(ggcorrplot)
library(tidyverse)
library(terra)
library(bslib)
library(shinyWidgets)
library(thematic)
library(showtext)
library(ragg)
library(ggplot2)
library(DT)
library(gghalves)
library(see)
library(markdown)
library(reshape2)

# Read in data
ATLAS <- read.csv("data.csv", stringsAsFactors = TRUE)

# Define UI for application 
ui <- fluidPage(
    theme = shinytheme("paper"),
    tags$head(tags$style("#video-container { margin-top: 40px; }")),
    navbarPage("MRShiny Brain",
               tabPanel("About",
                        sidebarPanel(
                            style = "background-color: gray87;",
                            p(HTML("<b><span style='font-size:20pt;'>Welcome to MRShiny Brain!</span></b>"), br(),
                            HTML("<br><b>A normative live database</b>"), br(),
                            HTML("<br>Our primary objective is to provide an accessible and user-friendly platform for the dissemination of multimodal MRI/MRS data."), br(),
                            br(),
                            HTML("<b>What can you do here?</b>")),
                            HTML("<ul>"),
                            HTML("<li><b>Engage with Comprehensive Data:</b> Access a wide range of morphological, functional, and biochemical data.</li>"),
                            HTML("<li><b>Explore the Healthy Brain:</b> Examine a normative representation of the healthy brain during resting state.</li>"),
                            HTML("<li><b>Empower Scientific Inquiry:</b> We aim to offer a resource to the scientific community for data-driven research.</li>"),
                            HTML("</ul>"),
                            br(),
                            HTML("<b>We believe that MRShiny Brain has the potential to significantly impact our understanding of the brain, and we invite you to participate in this collaborative exploratory endeavor.</b>"),
                            style = "font-size: 11pt;"
                        ),
                        uiOutput("about_tab"),
                        mainPanel(  
                            style = "position: relative; margin-top: 70px;",
                            img(src = "almost-shiny-V1.png", width =  "65%", style = "display: block; margin-left: auto; margin-right: auto;")
                        ), 
                        
               ),
               tabPanel("Study Team",
                        p(
                            HTML("<br><b></b>"), br(),
                            HTML("<b><span style='font-size: 20px;'>Investigators</span></b>")
                        ),
                        HTML("<ul>"),
                        HTML("<li> <b> Dr. Jessica Archibald  -</b> Radiology, Weill Cornell Medicine, New York, USA. </li>"),
                        HTML("<li> <b> Dr. Alexander Mark Weber -</b> Pediatrics, University of British Columbia, Vancouver, Canada. </li>"),
                        HTML("<li> <b> Dr. Paulina S. Scheuren -</b> Anesthesiology, Pharmacology, and Therapeutics, University of British Columbia, Vancouver, Canada. </li>"),
                        HTML("<li> <b> Oscar Ortiz -</b> MSc, Research Technician, ICORD, Vancouver, Canada. </li>"),
                        HTML("<li> <b> Jaime Lee -</b> BSc, Anesthesiology, Pharmacology, and Therapeutics, University of British Columbia, Vancouver, Canada </li>"),
                        HTML("<li> <b> Cassandra Choles -</b> MSc, Anesthesiology, Pharmacology, and Therapeutics, University of British Columbia, Vancouver, Canada. </li>"),
                        HTML("<li> <b> Dr. Niklaus Zölch -</b> Psychiatry and Forensic Medicine, Universität Zürich, Zürich, Switzerland. </li>"),
                        HTML("<li> <b> Dr. Erin L. MacMillan* -</b>  Radiology, University of British Columbia, Vancouver, Canada. ImageTech Lab, Simon Fraser University, Surrey, Canada. Philips Healthcare Canada, Markham, Canada.</li>"),
                        HTML("<li> <b> Dr. John L. K. Kramer* -</b> Anesthesiology, Pharmacology, and Therapeutics, University of British Columbia, Vancouver, Canada.</li>"),
                        HTML("</ul>"),
                        
                        HTML("*These two authors contributed equally "),
                        br(), 
                        HTML("<b><span style='font-size: 20px;'>Funding</span></b>"),
                        br(),
                        div(
                            style = "display: flex; align-items: center;",
                            img(src = "ubc.png", style = "width: 190px;"),
                            img(src = "nserc.png", style = "width: 150px; margin-left: 10px;")
                        ),
                        br(),
                        HTML("<b><span style='font-size: 20px;'>How to cite this work</span></b>"),
                        HTML("<br>If you find this work helpful or utilize any part of it in your research or publications, please consider citing it as follows:"), br(),
                        HTML("<br><b> J. Archibald, et.al. Integrating Structural, Functional, and Biochemical Brain Imaging Data with MRShiny Brain - An Interactive Web Application. [Journal]. [Year of Publication]. [URL or DOI]</b>."),br(),
                      
                        style = "font-size: 11pt;"
               ),  
               
               tabPanel("Study Description ", 
                        fluidRow(
                            column(width = 5.5,
                                   mainPanel(
                                       h2("Welcome to the Study Description page!"),
                                       p("This is where you can read more about our study and its design."), br(),
                                       p("Participants: Healthy individuals were invited to participate in the study and were asked to come to the laboratory in a fasting state."),
                                       p("The timing of the scan was kept consistent (11:30am-12:30pm) across participants (to account for circadian rhythm effects of metabolites [Eckel-Mahan et al Physiol Rev 2013])."),
                                       p("Women were tested approximately during the follicular phase of their cycle [Hjelmervik, H Neuroimage 2018]."),
                                       h3("MR Procedures:"),
                                       p("MRI data were collected using a 3T Philips Ingenia Elition X with a 32-channel SENSE head coil, and the sequences included:"),
                                       HTML("<ul>"),
                                       HTML("<li>MPRAGE 3D T1 (TE/TR/TI=4.3/9.3/950ms, shot interval=2400ms, +0.8mm³ isotropic resolution, FOV (ap/rl/fh)=256/256/180mm³, scan time=5:49).</li>"),
                                       HTML("<li>A pseudo-continuous arterial spin labelling (pCASL) sequence was used to assess CBF. The sequence consisted of 4 pairs of perfusion-weighted and control scans (TE/TR=12/4174ms, post-labelling duration=2000ms, labelling duration=1800, total scan duration=5.59 min).</li>"),
                                       HTML("<li>Single voxel 1H-MRS (sLASER, TE/TR=32/5000ms, NSA=64, voxel size=24/22/15mm³ =7.9mL, automated 2nd order shimming, 32-step phase cycle, water suppression using the frequency selective Excitation option). The order of MRS acquisition in the voxels was randomized for each participant.</li>"),
                                       HTML("</ul>"),
                                       h3("MR Analysis:"),
                                       tags$p(
                                       HTML("<u>Structural Measures</u>"),
                                           p("Image Segmentation was performed in FSL (v 6.05) using default options, ROI segmentation was performed using in-house MATLAB scripts.",
                                             "ROI Cortical Thickness was performed in native space for each subject using Freesurfer (v 7.2.0) -",
                                             tags$a(href = "https://github.com/arcj-hub/Freesurfer-CT-native-space", "Code availability.")),
                                       ),
                                       tags$p(
                                           HTML("<u>Perfusion</u>"),
                                           p("ROI perfusion levels were extracted in native space using ASLprep and FSL -",
                                             tags$a(href = "https://github.com/arcj-hub/ASLprep-CBF-Analysis", "Code availability.")
                                           )),
                                       
                                       HTML("<u>MR Spectroscopy</u>"),
                                       tags$p(
                                           p(" MRS data was pre-processed (e.g., frequency alignment, and eddy-current correction) and quantified using in-house MATLAB scripts. Spectral fitting was performed in LCModel (6.3). The basis set was simulated using FID-A functions. Simulated metabolites included: Ala, Asc, Asp, Cre, GABA, Gln, Glc, Glu, Gly, GPC, GSH, Ins, Lac, NAA, NAAG, PCr, PE, Scyllo, and Tau -",
                                             tags$a(href = "https://github.com/arcj-hub/ASLprep-CBF-Analysis", "Code availability.")
                                           )),
                                       tags$head(
                                         tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML")
                                       ),
                                       tags$p(
                                           HTML("<u>MRS Thermometry</u>"),
                                           p("After data pre-processing (i.e., frequency alignment, eddy current correction), local brain temperature (TB) was estimated by calculating the chemical shift difference between water and NAA measured in parts per million (ppm) using the following equation:",
                                             tags$div("$$TB(C) = 100 \\times [\\Delta(\\text{NAAppm} - \\text{waterppm}) + 2.665] + 37 \\quad \\text{(Equation 1)}$$"),
                                             tags$a(href = "(https://github.com/psscheuren", "Code availability.")
                                           )),
                                   )
                            ),
                            
                            column(width = 4, 
                                   div(style="text-align:center;",
                                       img(src = "ove_LS.png", style = "max-width:100%; height:auto;")
                                   )
                            )
                        )),   
               
               tabPanel("Structural Measures ", 
                        sidebarPanel( 
                            HTML("<h3>Input parameters</h3>"),
                            width = 3,
                            
                            selectInput("sex_sm","Sex:", 
                                        choices = c("male", "female", "All"),
                                        multiple= FALSE,
                                        selected = "All"
                            ),
                            selectInput("area_sm", "Brain area:", unique(ATLAS$area),
                                        selected = unique(ATLAS$area)[1],
                                        selectize = TRUE, multiple = TRUE
                            ),
                            
                            selectInput("outcome", label="Outcome Measure:", 
                                        choices = list("GM" = "GM", "WM" = "WM", "CSF" = "CSF", "CT" = "CT")
                                        
                            ),
                            
                            sliderInput("age_sm", "Age:",  min = 19, max = 50, value = c(20, 35)),
                            
                            img(src = "j3.png", width =  "100%" )
                            
                        ), # sidebarPanel_SM
                        
                        mainPanel(
                            tabsetPanel(
                                tabPanel("Plot", plotlyOutput("Plot_SM")),
                                tabPanel("Summary", dataTableOutput('tabledata_SM'),
                                         downloadButton("download_table_SM", "Download CSV")) # Results table with download button
                                
                            )
                        )), #main panel
               
               tabPanel("Perfusion", 
                        sidebarPanel( 
                            HTML("<h3>Input parameters</h3>"),
                            width = 3,
                            
                            selectInput("sex_fm","Sex:", 
                                        choices = c("male", "female", "All"),
                                        multiple= FALSE,
                                        selected = "All"
                                        
                            ),
                            selectInput("area_fm", "Brain area:", unique(ATLAS$area),
                                        selected = unique(ATLAS$area)[1],
                                        selectize = TRUE, multiple = TRUE
                                        
                            ),
                            
                            selectInput("outcome_fm", label="Outcome Measure:", 
                                        choices = list("CBF" = "CBF")
                                        
                            ),
                            
                            sliderInput("age_fm", "Age:",  min = 19, max = 50, value = c(20, 35)),
                            
                            img(src = "j3.png", width =  "100%" )
                            
                        ), # sidebarPanel_FM
                        
                        
                        mainPanel(
                            tabsetPanel(
                                tabPanel("Plot", plotlyOutput("Plot_FM")),
                                tabPanel("Summary", dataTableOutput('tabledata_FM'),
                                         downloadButton("download_table_FM", "Download CSV")) # Results table with download button
                            )
                        )), #main panel
               
               
               tabPanel("MR Spectroscopy",
                        sidebarPanel( 
                            HTML("<h3>Input parameters</h3>"),
                            width = 3,
                            
                            selectInput("sex","Sex:", 
                                        choices = c("male", "female", "All"),
                                        multiple= FALSE,
                                        selected = "All"
                                        
                            ),
                            selectInput("area", "Brain area:", unique(ATLAS$area),
                                        selected = unique(ATLAS$area)[1],
                                        selectize = TRUE, multiple = TRUE
                                        
                            ),
                            
                            selectInput("metabolite", label="Metabolite:", 
                                        choices = list("NAA" = "NAA", "tCr" = "CRE", "tCho" = "CHO", "mI" = "MI", "Glu"= "GLU",
                                                       "Gln"= "GLN", "Glx"= "GLX", "SNR"= "SNR", "water LW" ="H20LW")
                                        
                            ),
                            setSliderColor(c( "darkgray", "darkgray", "darkgray","darkgray", "darkgray"), c(1,2,3,4,5)),
                            
                            sliderInput("age", "Age:", min = 19, max = 50, value = c(20, 35)),
                            
                            img(src = "j3.png", width =  "100%" )
                            
                        ), # sidebarPanel
                        
                        mainPanel(
                            tabsetPanel(
                                tabPanel("Plot", plotlyOutput("Plot")),
                                tabPanel("Quality", plotlyOutput("Quality")),
                                tabPanel("Summary", dataTableOutput('tabledata'),
                                         downloadButton("download_table", "Download CSV")) # Results table with download button
                                
                            )
                        ) #main panel
               ), # Navbar 1, tabPanel
               tabPanel("MR Thermometry ", 
                        sidebarPanel( 
                            HTML("<h3>Input parameters</h3>"),
                            width = 3,
                            
                            selectInput("sex_tm","Sex:", 
                                        choices = c("male", "female", "All"),
                                        multiple= FALSE,
                                        selected = "All"
                            ),
                            selectInput("area_tm", "Brain area:", unique(ATLAS$area),
                                        selected = unique(ATLAS$area)[1],
                                        selectize = TRUE, multiple = TRUE
                            ),
                            
                            selectInput("outcome_tm", label="Outcome Measure:", 
                                        choices = list("Temperature" = "temp")
                                        
                            ),
                            
                            sliderInput("age_tm", "Age:",  min = 19, max = 50, value = c(20, 35)),
                            
                            img(src = "j3.png", width =  "100%" )
                            
                        ), # sidebarPanel_TemP
                        mainPanel(
                            tabsetPanel(
                                tabPanel("Plot", plotlyOutput("Plot_TeM")),
                                tabPanel("Summary", dataTableOutput('tabledata_TeM'),
                                         downloadButton("download_table_TeM", "Download CSV")) # Results table with download button
                                
                            )
                        )), #main panel
               
               
               tabPanel("Relationships", 
                        sidebarPanel( 
                            HTML("<h3>Variable Selection</h3>"),
                            width = 3,
                            
                            selectInput("sex_RT","Sex:", 
                                        choices = c("male", "female", "All"),
                                        multiple= FALSE,
                                        selected = "All"
                                        
                            ),
                            
                            selectInput("area_RT", "Brain area:", unique(ATLAS$area),
                                        selected = unique(ATLAS$area)[1],
                                        selectize = TRUE, multiple = FALSE
                                        
                            ),
                            
                            selectInput("x_var", "X Variable:", 
                                        choices = list(
                                            "GM" = "GM", 
                                            "WM" = "WM", 
                                            "CSF" = "CSF", 
                                            "CT" = "CT",
                                            "CBF" = "CBF", 
                                            "NAA" = "NAA", 
                                            "tCr" = "CRE", 
                                            "tCho" = "CHO", 
                                            "mI" = "MI", 
                                            "Glu"= "GLU",
                                            "Gln"= "GLN", 
                                            "Glx"= "GLX", 
                                            "SNR"= "SNR", 
                                            "water LW" ="H20LW",
                                            "temp"= "temp",
                                            "age"= "age"),
                                        
                                        multiple= FALSE,
                                        selected = "GM"
                                        
                            ),
                            
                            selectInput("y_var", "Y Variable:", 
                                        choices = list(
                                            "GM" = "GM", 
                                            "WM" = "WM", 
                                            "CSF" = "CSF", 
                                            "CT" = "CT",
                                            "CBF" = "CBF", 
                                            "NAA" = "NAA", 
                                            "tCr" = "CRE", 
                                            "tCho" = "CHO", 
                                            "mI" = "MI", 
                                            "Glu"= "GLU",
                                            "Gln"= "GLN", 
                                            "Glx"= "GLX", 
                                            "SNR"= "SNR", 
                                            "water LW" ="H20LW",
                                            "temp"= "temp",
                                            "age"= "age"),
                                        
                                        multiple= FALSE,
                                        selected = "CT"
                                        
                            ),
                            
                            sliderInput("age_RT", "Age:",  min = 19, max = 50, value = c(20, 35)),
                            img(src = "j3.png", width =  "100%" )
                            
                        ), # sidebarPanel
                        mainPanel(
                            tabsetPanel(
                                tabPanel("Plot", 
                                         plotlyOutput("Plot_RT"),
                                         verbatimTextOutput("disclaimer_text"),  # Add disclaimer text here
                                         plotlyOutput("Plot_RT2"),
                                         downloadButton("download_cor_M", "Download Cor Matrix")
                                         
                                ),
                                tabPanel("Summary", dataTableOutput('tabledata_RT'),
                                         downloadButton("download_table_RT", "Download CSV")) # Results table with download button
                                
                            )
                        )), #main panel
               
               
    )
)
#########################################################################################################################
# Define server logic required 
server <- function(input, output) {
    
    output$about_tab <- renderUI({
        absolutePanel(
            bottom = 0, left = 0, right = 0, height = "100px",
            tags$style(HTML("
      .my-class {
        background-color: white;
        padding: 10px;
      }
      .small-text {
        font-size: 15pt;
      }
    ")),
            div(class = "my-class",
                tags$h3(" ", class = "small-text"),
                tags$div(
                    "2023 Jessica Archibald",
                    style = "background-color: gray96; padding: 10px;"
                )
            )
        )
    })
    
    output$video <- renderUI({
        tags$video(src = "almost-shiny.mp4", type = "video/mp4", autoplay = NA, controls = NA, height = 350, width = 600)
    })
    
    
    # Placeholder code for MR Spectroscopy tab
    output$Plot <- renderPlotly({
        data <- ATLAS[ATLAS$area %in% input$area &
                          ATLAS$age >= input$age[1] & ATLAS$age <= input$age[2], ]
        data <- data[!is.na(data$sex),]
        
        if (input$sex != "All") {
            data <- data[data$sex == input$sex,]
        }
        
        data$area <- factor(data$area, levels = input$area)
        
        
        # Subset data based on selected areas
        selected_data <- data[data$area %in% input$area,]
        
        if (length(unique(selected_data$sex)) > 1) {
            p <- ggplot(selected_data, aes(x = area, y = data[[input$metabolite]], fill = "All areas")) +
                geom_violin(alpha = 0.5, trim = FALSE, color = NA) +
                geom_jitter(width = 0.3, alpha = 0.3) +
                geom_line(aes(group = unique_ID), color = "black", alpha = 0.3) +
                
                labs(
                    y = ifelse(input$metabolite == "H20LW", "LW (Hz)",
                               ifelse(input$metabolite == "SNR", "", paste(input$metabolite, "(mM)"))),
                    fill = ""
                ) +
                scale_fill_manual(values = c("All areas" = "darkred")) +
                theme_light() +
                theme(legend.position = "none")
        } else {
            p <- ggplot(selected_data, aes(x = area, y = data[[input$metabolite]], fill = "All areas")) +
                geom_violin(alpha = 0.5, trim = FALSE, color = NA) +
                geom_jitter(width = 0.3, alpha = 0.3) +
                geom_line(aes(group = unique_ID), color = "black", alpha = 0.3) +
                
                labs(
                    y = ifelse(input$metabolite == "H20LW", "LW (Hz)",
                               ifelse(input$metabolite == "SNR", " SNR ", paste(input$metabolite, "(mM)"))),
                    fill = ""
                ) +
                scale_fill_manual(values = c("All areas" = "darkred")) +
                theme_light() +
                theme(legend.position = "none")
            
            
        }
        
        ggplotly(p)
    })
    
    
    # Quality plot
    output$Quality <- renderPlotly({
        data <- ATLAS[ATLAS$area %in% input$area &
                          ATLAS$age >= input$age[1] & ATLAS$age <= input$age[2], ]
        data <- data[!is.na(data$sex),]
        
        if (input$sex != "All") {
            data <- data[data$sex == input$sex,]
        }
        
        # Subset data based on selected areas
        selected_data <- data[data$area %in% input$area,]
        # Create a factor variable with the levels in the order of selection
        area_order <- factor(selected_data$area, levels = input$area)
        
        # Plot CRLB
        p <- ggplot(selected_data, aes(x = area_order, y = !!sym(paste0("CRLB_", input$metabolite)))) +
            
            geom_violin(fill = "darkblue", alpha = 0.5, color= NA) +
            geom_jitter(width = 0.1, alpha = 0.5) +
            labs(y = paste0("CRLB_", input$metabolite)) +
            labs(x = 'Brain areas') +
            theme_light()
        
        ggplotly(p)
        
    })
    # Summary data 
    output$tabledata <- renderDataTable({
        req(input$area)
        if (input$sex == "All") {
            data <- ATLAS[ATLAS$area %in% input$area & 
                              ATLAS$age >= input$age[1] & ATLAS$age <= input$age[2], ]
            data <- subset(data, !is.na(sex))
        } else {
            data <- ATLAS[ATLAS$area %in% input$area & ATLAS$sex %in% input$sex &
                              ATLAS$age >= input$age[1] & ATLAS$age <= input$age[2], ]
        }
        data <- select(data, unique_ID, area, sex, age, input$metabolite)
        # Format the values in the 'input$outcome' column with four decimal places
        data[[input$metabolite]] <- format(data[[input$metabolite]], digits = 4, nsmall = 4)
        
        datatable(data, options = list(
            columnDefs = list(list(
                targets = c(0), # column indices or names to hide
                visible = FALSE
            )),
            dom = 'lBfrtip',
            buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
        ))
    })
    output$download_table <- downloadHandler(
        filename = function() {
            paste("table_data", Sys.Date(), ".csv", sep = "")
        },
        content = function(file) {
            if (input$sex == "All") {
                data <- ATLAS[ATLAS$area %in% input$area & 
                                  ATLAS$age >= input$age[1] & ATLAS$age <= input$age[2], ]
                data <- subset(data, !is.na(sex))
            } else {
                data <- ATLAS[ATLAS$area %in% input$area & ATLAS$sex %in% input$sex &
                                  ATLAS$age >= input$age[1] & ATLAS$age <= input$age[2], ]
            }
            data <- select(data, unique_ID, area, sex, age,  input$metabolite)
            write.csv(data, file)
        }
    )
    
    # Temperature 
    output$Plot_TeM <- renderPlotly({
      data <- ATLAS[ATLAS$area %in% input$area_tm &
                      ATLAS$age >= input$age_tm[1] & ATLAS$age <= input$age_tm[2], ]
      data <- data[!is.na(data$sex),]
      
      if (input$sex_fm != "All") {
        data <- data[data$sex == input$sex_tm,]
      }
      
      data$area <- factor(data$area, levels = input$area_tm)
      data$area <- factor(data$area, levels = input$area_tm)
      
      # Subset data based on selected areas
      selected_data <- data[data$area %in% input$area_tm,]
      
      if (length(unique(selected_data$sex)) > 1) {
        p <-   ggplot(selected_data, aes(x = area, y = data[[input$outcome_tm]], fill = "All areas")) +
          geom_violin(alpha = 0.5, trim = FALSE, color = NA) +
          geom_jitter(width = 0.3, alpha = 0.3) +
          geom_line(aes(group = unique_ID), color = "black", alpha = 0.3) +
          labs(
            y = ifelse(input$outcome_sm %in% c("XX", "XX"),
                       ifelse(input$outcome_sm == "XX",
                              ifelse(input$outcome_tm == "temp", "Temperature (C)", input$outcome_tm))),
            fill = ""
          ) +
          scale_fill_manual(values = c("All areas" = "darkslategray4")) +
          theme_light() +
          theme(legend.position = "none")
      } else {
        p <-   ggplot(selected_data, aes(x = area, y = data[[input$outcome_tm]], fill = "All areas")) +
          geom_violin(alpha = 0.5, trim = FALSE, color = NA) +
          geom_jitter(width = 0.3, alpha = 0.3) +
          geom_line(aes(group = unique_ID), color = "black", alpha = 0.3) +
          labs(
            y = ifelse(input$outcome_sm %in% c("XX", "XX"),
                       ifelse(input$outcome_tm == "XX",
                              ifelse(input$outcome_tm == "temp", "Temperature (C)", input$outcome_tm))),
            fill = ""
          ) +
          scale_fill_manual(values = c("All areas" = "darkslategray4")) +
          theme_light() +
          theme(legend.position = "none")
        ggplotly(p)
        
      }
    })
    
    # Summary Data
    output$tabledata_TeM <- renderDataTable({
      req(input$area_tm)
      if (input$sex_tm == "All") {
        data <- ATLAS[ATLAS$area %in% input$area_tm & 
                        ATLAS$age >= input$age_tm[1] & ATLAS$age <= input$age_tm[2], ]
        data <- subset(data, !is.na(sex))
      } else {
        data <- ATLAS[ATLAS$area %in% input$area_tm & ATLAS$sex %in% input$sex_tm &
                        ATLAS$age >= input$age_tm[1] & ATLAS$age <= input$age_tm[2], ]
      }
      data <- select(data,unique_ID, area, sex, age, input$outcome_tm)
      # Format the values in the 'input$outcome' column with four decimal places
      data[[input$outcome_tm]] <- format(data[[input$outcome_tm]], digits = 4, nsmall = 4)
      
      datatable(data, options = list(
        columnDefs = list(list(
          targets = c(0), # column indices or names to hide
          visible = FALSE
        )),
        dom = 'lBfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
      ))
    })
    output$download_table_TeM <- downloadHandler(
      filename = function() {
        paste("table_data", Sys.Date(), ".csv", sep = "")
      },
      content = function(file) {
        if (input$sex_tm == "All") {
          data <- ATLAS[ATLAS$area %in% input$area_tm & 
                          ATLAS$age >= input$age_tm[1] & ATLAS$age <= input$age_tm[2], ]
          data <- subset(data, !is.na(sex))
        } else {
          data <- ATLAS[ATLAS$area %in% input$area_tm & ATLAS$sex %in% input$sex_tm &
                          ATLAS$age >= input$age_tm[1] & ATLAS$age <= input$age_tm[2], ]
        }
        data <- select(data,unique_ID, area, sex, age, input$outcome_tm)
        write.csv(data, file)
      }
    )
    
    

    # Functional Measures
    output$Plot_FM <- renderPlotly({
        data <- ATLAS[ATLAS$area %in% input$area_fm &
                          ATLAS$age >= input$age_fm[1] & ATLAS$age <= input$age_fm[2], ]
        data <- data[!is.na(data$sex),]
        
        if (input$sex_fm != "All") {
            data <- data[data$sex == input$sex_fm,]
        }
        
        data$area <- factor(data$area, levels = input$area_fm)
        data$area <- factor(data$area, levels = input$area_fm)
        
        # Subset data based on selected areas
        selected_data <- data[data$area %in% input$area_fm,]
        
        if (length(unique(selected_data$sex)) > 1) {
            p <-   ggplot(selected_data, aes(x = area, y = data[[input$outcome_fm]], fill = "All areas")) +
                geom_violin(alpha = 0.5, trim = FALSE, color = NA) +
                geom_jitter(width = 0.3, alpha = 0.3) +
                geom_line(aes(group = unique_ID), color = "black", alpha = 0.3) +
                labs(
                    y = ifelse(input$outcome_fm %in% c("XX", "XX"), "Amplitude (a.u.)",
                               ifelse(input$outcome_fm == "XX", "Area Under the Curve",
                                      ifelse(input$outcome_fm == "CBF", "CBF (mL/gr/min)", input$outcome_fm))),
                    fill = ""
                ) +
                scale_fill_manual(values = c("All areas" = "darkslategray4")) +
                theme_light() +
                theme(legend.position = "none")
        } else {
            p <-   ggplot(selected_data, aes(x = area, y = data[[input$outcome_fm]], fill = "All areas")) +
                geom_violin(alpha = 0.5, trim = FALSE, color = NA) +
                geom_jitter(width = 0.3, alpha = 0.3) +
                geom_line(aes(group = unique_ID), color = "black", alpha = 0.3) +
                labs(
                    y = ifelse(input$outcome_fm %in% c("XX", "XX"), "Amplitude (a.u.)",
                               ifelse(input$outcome_fm == "XX", "Area Under the Curve",
                                      ifelse(input$outcome_fm == "CBF", "CBF (mL/gr/min)", input$outcome_fm))),
                    fill = ""
                ) +
                scale_fill_manual(values = c("All areas" = "darkslategray4")) +
                theme_light() +
                theme(legend.position = "none")
            ggplotly(p)
            
        }
    })
    
    # Summary Data
    output$tabledata_FM <- renderDataTable({
        req(input$area_fm)
        if (input$sex_fm == "All") {
            data <- ATLAS[ATLAS$area %in% input$area_fm & 
                              ATLAS$age >= input$age_fm[1] & ATLAS$age <= input$age_fm[2], ]
            data <- subset(data, !is.na(sex))
        } else {
            data <- ATLAS[ATLAS$area %in% input$area_fm & ATLAS$sex %in% input$sex_fm &
                              ATLAS$age >= input$age_fm[1] & ATLAS$age <= input$age_fm[2], ]
        }
        data <- select(data,unique_ID, area, sex, age, input$outcome_fm)
        # Format the values in the 'input$outcome' column with four decimal places
        data[[input$outcome_fm]] <- format(data[[input$outcome_fm]], digits = 4, nsmall = 4)
        
        datatable(data, options = list(
            columnDefs = list(list(
                targets = c(0), # column indices or names to hide
                visible = FALSE
            )),
            dom = 'lBfrtip',
            buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
        ))
    })
    output$download_table_FM <- downloadHandler(
        filename = function() {
            paste("table_data", Sys.Date(), ".csv", sep = "")
        },
        content = function(file) {
            if (input$sex_fm == "All") {
                data <- ATLAS[ATLAS$area %in% input$area_fm & 
                                  ATLAS$age >= input$age_fm[1] & ATLAS$age <= input$age_fm[2], ]
                data <- subset(data, !is.na(sex))
            } else {
                data <- ATLAS[ATLAS$area %in% input$area_fm & ATLAS$sex %in% input$sex_fm &
                                  ATLAS$age >= input$age_fm[1] & ATLAS$age <= input$age_fm[2], ]
            }
            data <- select(data,unique_ID, area, sex, age, input$outcome_fm)
            write.csv(data, file)
        }
    )
    # Structural Measures
    # Plot data 
    output$Plot_SM <- renderPlotly({
        data <- ATLAS[ATLAS$area %in% input$area_sm &
                          ATLAS$age >= input$age_sm[1] & ATLAS$age <= input$age_sm[2], ]
        data <- data[!is.na(data$sex),]
        
        if (input$sex_sm != "All") {
            data <- data[data$sex == input$sex_sm,]
        }
        
        data$area <- factor(data$area, levels = input$area_sm)
        
        # Subset data based on selected areas
        selected_data <- data[data$area %in% input$area_sm,]
        
        if (length(unique(selected_data$sex)) > 1) {
            p <-   ggplot(selected_data, aes(x = area, y = data[[input$outcome]], fill = "All areas")) +
                geom_violin(alpha = 0.5, trim = FALSE, color = NA) +
                geom_jitter(width = 0.3, alpha = 0.3) +
                geom_line(aes(group = unique_ID), color = "black", alpha = 0.3) +
                labs(y = ifelse(input$outcome == "CT", "CT (mm)", paste(input$outcome, "(fractional percentage)")), fill = "") +
                
                scale_fill_manual(values = c("All areas" = "goldenrod3")) +
                theme_light() +
                theme(legend.position = "none")
        } else {
            p <-  ggplot(selected_data, aes(x = area, y = data[[input$outcome]], fill = "All areas")) +
                geom_violin(alpha = 0.5, trim = FALSE, color = NA) +
                geom_jitter(width = 0.3, alpha = 0.3) +
                geom_line(aes(group = unique_ID), color = "black", alpha = 0.3) +
                labs(y = ifelse(input$outcome == "CT", "CT (mm)", paste(input$outcome, "(fractional percentage)")), fill = "") +
                
                scale_fill_manual(values = c("All areas" = "goldenrod3")) +
                theme_light() +
                theme(legend.position = "none")
            ggplotly(p)
            
        }
    })
    
    # Summary Data
    output$tabledata_SM <- renderDataTable({
        req(input$area_sm)
        if (input$sex_sm == "All") {
            data <- ATLAS[ATLAS$area %in% input$area_sm & 
                              ATLAS$age >= input$age_sm[1] & ATLAS$age <= input$age_sm[2], ]
            data <- subset(data, !is.na(sex))
        } else {
            data <- ATLAS[ATLAS$area %in% input$area_sm & ATLAS$sex %in% input$sex_sm &
                              ATLAS$age >= input$age_sm[1] & ATLAS$age <= input$age_sm[2], ]
        }
        data <- select(data, unique_ID,area, sex, age, input$outcome)
        
        # Format the values in the 'input$outcome' column with four decimal places
        data[[input$outcome]] <- format(data[[input$outcome]], digits = 4, nsmall = 4)
        
        datatable(data, options = list(
            columnDefs = list(list(
                targets = c(0), # column indices or names to hide
                visible = FALSE
            )),
            dom = 'lBfrtip',
            buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
        ))
    })
    output$download_table_SM <- downloadHandler(
        filename = function() {
            paste("table_data", Sys.Date(), ".csv", sep = "")
        },
        content = function(file) {
            if (input$sex_fm == "All") {
                data <- ATLAS[ATLAS$area %in% input$area_sm & 
                                  ATLAS$age >= input$age_sm[1] & ATLAS$age <= input$age_sm[2], ]
                data <- subset(data, !is.na(sex))
            } else {
                data <- ATLAS[ATLAS$area %in% input$area_sm & ATLAS$sex %in% input$sex_sm &
                                  ATLAS$age >= input$age_sm[1] & ATLAS$age <= input$age_sm[2], ]
            }
            data <- select(data,unique_ID, area, sex, age, input$outcome)
            write.csv(data, file)
        }
    )
    
    # Relationships tab
    output$Plot_RT <- renderPlotly({
        
        data <- ATLAS[ATLAS$area %in% input$area_RT &
                          ATLAS$age >= input$age_RT[1] & ATLAS$age <= input$age_RT[2], ]
        data <- data[!is.na(data$sex),]
        
        if (input$sex_RT != "All") {
            data <- data[data$sex == input$sex_RT,]
        }
        
        data$area <- factor(data$area, levels = input$area_RT)
        
        # Subset data based on selected areas
        selected_data <- data[data$area %in% input$area_RT,]
        
        
        p <- ggplot(selected_data, aes(x = data[[input$x_var]], y = data[[input$y_var]])) +
            geom_point() +
            geom_smooth(method = "lm", se = FALSE, color = "darkgray") +
            labs(x = input$x_var, y = input$y_var) +
            theme_light() 
        
        
        #r_squared <- round(summary(lm(data[[input$y_var]] ~ data[[input$x_var]]))$r.squared, 2)
        p <- ggplotly(p)  # Convert to Plotly object
        #p <- p %>% layout(annotations = list(x = 0.95, y = 0.9, text = paste("R-squared: ", r_squared),
        # xref = "paper", yref = "paper", showarrow = FALSE))
        
    })
    
    output$Plot_RT2 <- renderPlotly({
        # Define the disclaimer text
        disclaimer_text <- "Disclaimer: 
      Please interpret the correlations presented here with caution. 
      The variables in this dataset may violate certain statistical assumptions. 
      We encourage users to download the dataset, conduct tests for normality, correct for multiple comparissons etc. 
      and perform their own statistical analyses to ensure the validity and reliability of their findings."
        
        # Output the disclaimer text
        output$disclaimer_text <- renderText({
            disclaimer_text
        })
        
        data <- ATLAS[ATLAS$area %in% input$area_RT,]
        
        # Calculate the correlation matrix
        # List of variables you want to include in the correlation analysis
        included_vars <- c('GM', 'WM', 'CSF', 'CT','CBF','GLU','GLN','GLX', 'NAA', 'MI','CRE', 'CHO','temp','age')  #
        
        # Subsetting the dataset to include only the selected variables
        subset_data <- data[, included_vars]
        
        # Calculate the correlation matrix
        correlation_matrix <- cor(subset_data, use = 'pairwise.complete.obs')
        correlation_matrix<- as.data.frame(correlation_matrix)
        
        correlation_matrix$Var1 <- rownames(correlation_matrix)
        
        
        # Melt the data
        melted_correlation <- melt(correlation_matrix, id.vars = "Var1")
        
        # Rename the columns for consistency with previous examples
        colnames(melted_correlation) <- c("X", "Y", "value")
        # Get the order of variables on the Y-axis
        y_order <- melted_correlation$Y
        
        # Reorder the levels of the "X" factor based on the order of variables on the Y-axis
        melted_correlation$X <- factor(melted_correlation$X, levels = unique(c(y_order, melted_correlation$X)))
        
        # Create a heatmap-like correlation plot
        heat_cor_plot <- ggplot(data = melted_correlation, aes(X, Y, fill = value)) +
            geom_tile() +
            scale_fill_gradient2(low = "royalblue4", mid = "white", high = "red3", midpoint = 0) +
            theme_minimal() +
            labs(title = "Overall Correlation Heatmap by Brain Area")
        
        heat_cor_plot <- ggplotly(heat_cor_plot)  # Convert to Plotly object
        
    })
    #DOWNLOAD COR MARTIX 
    
    # Define a reactive value for correlation_matrix
    correlation_matrix <- reactive({
        data <- ATLAS[ATLAS$area %in% input$area_RT,]
        included_vars <- c('GM', 'WM', 'CSF', 'CT','CBF','GLU','GLN','GLX', 'NAA', 'MI','CRE', 'CHO', 'temp','age')
        subset_data <- data[, included_vars]
        return(cor(subset_data, use = 'pairwise.complete.obs'))
    })
    
    output$download_cor_M <- downloadHandler(
        filename = function() {
            paste("correlation_matrix", Sys.Date(), ".csv", sep = "")
        },
        content = function(file) {
            correlation_matrix_data <- correlation_matrix()
            write.csv(correlation_matrix_data, file)
        }
    )
    
    
    # Summary Data  
    output$tabledata_RT <- renderDataTable({
        req(input$area_RT)
        if (input$sex_RT == "All") {
            data <- ATLAS[ATLAS$area %in% input$area_RT & 
                              ATLAS$age >= input$age_RT[1] & ATLAS$age <= input$age_RT[2], ]
            data <- subset(data, !is.na(sex))
        } else {
            data <- ATLAS[ATLAS$area %in% input$area_RT & ATLAS$sex %in% input$sex_RT &
                              ATLAS$age >= input$age_RT[1] & ATLAS$age <= input$age_RT[2], ]
        }
        data <- select(data, unique_ID, area, sex, age, input$x_var, input$y_var)
        # Format the values in the 'input$outcome' column with four decimal places
        data[[input$x_var]] <- format(data[[input$x_var]], digits = 4, nsmall = 4)
        data[[input$y_var]] <- format(data[[input$y_var]], digits = 4, nsmall = 4)
        datatable(data, options = list(
            columnDefs = list(list(
                targets = c(0), # column indices or names to hide
                visible = FALSE
            )),
            dom = 'lBfrtip',
            buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
        ))
    })
    output$download_table_RT <- downloadHandler(
        filename = function() {
            paste("table_data", Sys.Date(), ".csv", sep = "")
        },
        content = function(file) {
            if (input$sex_RT == "All") {
                data <- ATLAS[ATLAS$area %in% input$area_RT & 
                                  ATLAS$age >= input$age_RT[1] & ATLAS$age <= input$age_RT[2], ]
                data <- subset(data, !is.na(sex))
            } else {
                data <- ATLAS[ATLAS$area %in% input$area_RT & ATLAS$sex %in% input$sex_RT &
                                  ATLAS$age >= input$age_RT[1] & ATLAS$age <= input$age_RT[2], ]
            }
            data <- select(data, unique_ID,area, sex, age, input$x_var, input$y_var)
            write.csv(data, file)
        }
    )
}
# Run the application 
shinyApp(ui, server)
