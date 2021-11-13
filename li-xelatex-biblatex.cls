%% li-xelatex-biblatex.cls
%% Version 0.1
%
% This work consists of the files li-xelatex-biblatex.cls,
% example.tex, example.bib.
%
% This (Xe)LaTeX class provides a document class that aims to conform to the
% requirements of Linguistic Inquiry
% (https://www.mitpressjournals.org/userimages/ContentEditor/1248106497613/Style%20Sheet%207.6.09.pdf)
% It is intended to be used with XeLaTeX and biblatex.
%
% Changes:
% Version 0.1: Initial release.

%%% Identification

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{li-xelatex-biblatex}[2020/04/10 v0.1 Class for Linguistic Inquiry articles]

%%% Declarations

\LoadClass[headings=small,abstract=true]{scrartcl}

\RequirePackage{polyglossia}
\setdefaultlanguage{english}
\RequirePackage[autostyle=true,english=american]{csquotes}

%% biblatex
\RequirePackage[%
        backend=biber,
        citestyle=li-authoryear-comp,
        bibstyle=li-authoryear,
        mincrossrefs=3,
        backref=false,
        maxbibnames=9]{biblatex}

\newcommand{\blx@nowarnpolyglossia}{}

%% fontspec and unicode-math
\RequirePackage[warnings-off={mathtools-colon}]{unicode-math}
\RequirePackage{fontspec}
\defaultfontfeatures{Mapping=tex-text}
\usepackage{xltxtra}

\setmainfont[BoldFont = XITS-Bold.otf,
             BoldItalicFont = XITS-BoldItalic.otf,
             ItalicFont = XITS-Italic.otf]{XITS-Regular.otf}
\setmathfont[BoldFont = XITSMath-Bold.otf]{XITSMath-Regular.otf}
\unimathsetup{math-style=upright}

%% Dimensions
\RequirePackage{geometry}

%% hyperref
\RequirePackage[unicode,hidelinks]{hyperref}

%% Options
\RequirePackage{xifthen}

%%% Class options

%% You can use letter dimensions with the "letter" option
\newboolean{a4paper}
\setboolean{a4paper}{true}
\newboolean{letter}
\setboolean{letter}{false}

%% You can use Times New Roman with the "timesnewroman" option
\newboolean{xits}
\setboolean{xits}{true}
\newboolean{timesnewroman}
\setboolean{timesnewroman}{false}

\DeclareOption{timesnewroman}{\setboolean{xits}{false}\setboolean{timesnewroman}{true}}
\DeclareOption{letter}{\setboolean{a4paper}{false}\setboolean{letter}{true}}

\ProcessOptions*

%%% Class commands and other properties

%% Paper size
\ifthenelse{\boolean{a4paper}}{%
    \geometry{a4paper,
              left=1.25in,
              right=1.25in,
              top=1.25in,
          bottom=1.25in}
}

\ifthenelse{\boolean{letter}}{%
    \geometry{letterpaper,
              left=1.25in,
              right=1.25in,
              top=1.25in,
          bottom=1.25in}
}

%% Spacing and ragged right margin
\RequirePackage{setspace}
\doublespacing

\RequirePackage{ragged2e}
\setlength{\RaggedRightParindent}{\parindent}
\RaggedRight

%% Simple page layout with only page numbers
\RequirePackage[singlespacing=true]{scrlayer-scrpage}
\pagestyle{plain}

%% Title
\date{} % no need for date
\setkomafont{title}{\normalfont\bfseries}
% Add affiliation for (each) author in \author{...} command

%% Headings

\setkomafont{section}{\bfseries}
\setkomafont{subsection}{\normalfont}
\setkomafont{subsubsection}{\normalfont}

%% Abstract and keywords

\renewenvironment{abstract}%
    {\begin{quotation}\noindent \emph{Abstract:} }
    {\end{quotation}}

\newcommand{\keywords}[1]%
    {\begin{quotation}\noindent \emph{Keywords:} #1\end{quotation}}

%% Contact information at the end of the paper

\newcommand{\contact}[2]%
    {%
    \setlength{\parindent}{0pt}%
    \singlespacing%
    \emph{#1}\\[.33\baselineskip]
    \emph{\href{mailto:#2}{#2}}
    }

%% Notes
\RequirePackage{endnotes}
\let\footnote=\endnote

%% Use filename.bib as default bibliography source
\addbibresource{\jobname.bib}
