\ProvidesClass{friggeri-cv-cn}[2012/04/30 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}

%%%%%%%%%%
% Colors %
%%%%%%%%%%

\RequirePackage{xcolor}

\definecolor{white}{RGB}{255,255,255}

\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{lightgray}{HTML}{999999}

\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}

\ifdefined\@cv@print
  \colorlet{green}{gray}
  \colorlet{orange}{gray}
  \colorlet{purple}{gray}
  \colorlet{brown}{gray}
  \colorlet{red}{gray}
  \colorlet{blue}{gray}
  \colorlet{fillheader}{white}
  \colorlet{header}{gray}
\else
  \colorlet{fillheader}{gray}
  \colorlet{header}{white}
\fi
\colorlet{textcolor}{white}
\colorlet{headercolor}{gray}

%%%%%%%%%%%%%%%%%%%
% Chinese Characters %
%%%%%%%%%%%%%%%%%%%

\RequirePackage{xeCJK}

%%%%%%%%%%%%%%
% Main Fonts %
%%%%%%%%%%%%%%
\RequirePackage{fontspec}
\setmainfont[Mapping=tex-text, Color=textcolor]{Arial}

%%%%%%%%%
% Chinese Characters Fonts %
%%%%%%%%%

\RequirePackage[math-style=TeX,vargreek-shape=unicode]{unicode-math}

\newCJKfontfamily\bodyfont[]{WenQuanYi Micro Hei Mono}
\newCJKfontfamily\thinfont[]{WenQuanYi Micro Hei}
\newCJKfontfamily\headingfont[]{WenQuanYi Micro Hei}

%\defaultCJKfontfeatures{Mapping=tex-text}
\setCJKmainfont[Color=textcolor]{WenQuanYi Micro Hei}

%\setmathfont{XITS Math}

%%%%%%%%%%
% Header %
%%%%%%%%%%

\RequirePackage{tikz}

\newcommand{\rolefont}{%
  \fontsize{14pt}{24pt}\selectfont%
  \thinfont%
  \color{white}%
}

\newcommand{\header}[3]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=4cm] (box) at (current page.north){};
    \node [anchor=center] (name) at (box) {%
      \fontsize{40pt}{72pt}\color{header}%
      {\bodyfont #1}{\bodyfont  #2}
    };
    \node [anchor=north] at (name.south) {%
      \fontsize{14pt}{24pt}\color{header}%
      \thinfont #3%
    };
  \end{tikzpicture}
  \vspace{2.5cm}
  \vspace{-2\parskip}
}


%%%%%%%%%%%%%
% Structure %
%%%%%%%%%%%%%
\RequirePackage{parskip}

\newcounter{colorCounter}
\def\@sectioncolor#1#2{%
  {%
    \color{%
      \ifcase\value{colorCounter}%
        blue\or%
        red\or%
        orange\or%
        green\or%
        purple\or%
        brown\else%
        headercolor\fi%
    } #1#2%
  }%
  \stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
  \par\vspace{\parskip}
  {%
    \LARGE\headingfont\color{headercolor}%
    \@sectioncolor #1%
  }
  \par\vspace{\parskip}
}

\renewcommand{\subsection}[2]{
  \par\vspace{.5\parskip}%
  \Large\headingfont\color{headercolor} #2%
  \par\vspace{.25\parskip}%
}

\pagestyle{empty}


%%%%%%%%%%%%%%%%%%%%
% List environment %
%%%%%%%%%%%%%%%%%%%%
\RequirePackage{setspace}
\RequirePackage{longtable}

\setlength{\tabcolsep}{0pt}

\newenvironment{entrylist}{%
  \setlength\LTleft{0pt}
  \setlength\LTright{0pt}
  \begin{longtable}{@{\extracolsep{\fill}}ll}
}{%
  \end{longtable}
}
\renewcommand{\bfseries}{\headingfont\color{headercolor}}
\newcommand{\entry}[4]{%
  #1&\parbox[t]{11.3cm}{%  create a box, with 11.8cm width
    \setstretch{1.3} % row space
    \textbf{#2} % bold font
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #3}\\%
    #4\vspace{\parsep}%
  }\\}


%%%%%%%%%%%%%%
% Side block %
%%%%%%%%%%%%%%

\RequirePackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\newenvironment{aside}{%
  \let\oldsection\section
  \renewcommand{\section}[1]{
    \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}
  }
  \begin{textblock}{3.6}(1.5, 4.33)
  \begin{flushright}
  \obeycr
}{%
  \restorecr
  \end{flushright}
  \end{textblock}
  \let\section\oldsection
}

%%%%%%%%%%%%%%%%
% Bibliography %
%%%%%%%%%%%%%%%%

\RequirePackage[style=verbose, maxnames=99, sorting=ydnt, backend=biber, firstinits=true]{biblatex}

\DeclareFieldFormat[patent]{title}{#1\par}

\DeclareBibliographyDriver{patent}{%
	\printfield{title}%
	\newblock%
	\footnotesize\addfontfeature{Color=lightgray}\printnames{author}%
	\par%
	\newblock%
	{%
		\footnotesize\addfontfeature{Color=lightgray}\itshape%
		\printfield{number}%
		\setunit*{\addcomma\space}%
		\printfield{year}%
		\setunit*{\addcomma\space}%
		\printfield{holder}%
		\setunit*{\addcomma\space}%
		\printfield{url}%
	}
	\par\vspace{0.3\baselineskip}
}

\DeclareFieldFormat{url}{\addcolon\space\bibstring{<}\url{#1}\bibstring{>}}

\renewcommand{\UrlFont}{\small\rm}

\defbibheading{bibheading}[\bibname]{%
	\subsubsection*{#1}
	\markboth{#1}{#1}
}

\newcommand{\printbibsection}[1]{
	\begin{refsection}
		\nocite{*}
		\printbibliography[type={#1}, heading=none]
	\end{refsection}
}



%%%%%%%%%%%%%%%%
% Other tweaks %
%%%%%%%%%%%%%%%%

\RequirePackage[left=6.1cm,top=2cm,right=1.5cm,bottom=0.5cm,nohead,nofoot]{geometry}
\RequirePackage[hidelinks]{hyperref}
\hypersetup{
	colorlinks=false,       
	linkcolor=red,          
	citecolor=red,        
	filecolor=red,      
	urlcolor = red}

\RequirePackage{enumitem}
\setlist[itemize]{leftmargin=*}

% A fix for \href{}{} colors not working with fontspec
\makeatletter
\def\HyColor@@@@UseColor#1\@nil{\addfontfeatures{Color=#1}}
\makeatother
