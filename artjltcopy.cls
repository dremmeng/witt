%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is ARTJLT.CLS, a document class for AUTHORS and EDITORS of
%  JOURNAL OF LIE THEORY
% for LaTeX2e files.
% Version of April 8, 2018 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%
%%% identification %%%
%%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{artjlt}[2014/02/27]

%%%
%%% initial code %%%
%%%
\RequirePackage{ifthen}
\newboolean{editormode}
\newboolean{languageset}

% Captionnames in ENGLISH, FRENCH, and GERMAN
%

%% ENGLISH

\newcommand*\englishcaptions{%
\def\theoremname{Theorem}
\def\propositionname{Proposition}
\def\corollaryname{Corollary}
\def\lemmaname{Lemma}
\def\remarkname{Remark}
\def\definitionname{Definition}
\def\exercisename{Exercise}
\def\examplename{Example}
\def\examplesname{Examples}
\def\conjecturename{Conjecture}
\def\problemname{Problem}
\def\problemsname{Problems}
\def\proofname{Proof}
%\def\abstractname{Abstract}
\def\referencesname{References}
}

%% FRENCH

\newcommand*\frenchcaptions{%
\def\theoremname{Th\'eor\`eme}
\def\propositionname{Proposition}
\def\corollaryname{Corollaire}
\def\lemmaname{Lemme}
\def\remarkname{Remarque}
\def\definitionname{D\'efinition}
\def\exercisename{Exercise}
\def\examplename{Exemple}
\def\examplesname{Exemples}
\def\conjecturename{Conjecture}
\def\problemname{Probl\`eme}
\def\problemsname{Probl\`emes}
%\def\proofname{D\'emonstration}
\def\proofname{Preuve}
%\def\abstractname{R\'esum\'e}
%\def\referencesname{R\'ef\'erences}
\def\referencesname{Bibliographie}
}

%% GERMAN

\newcommand*\germancaptions{%
\def\theoremname{Theorem}
\def\propositionname{Proposition}
\def\corollaryname{Korollar}
\def\lemmaname{Lemma}
\def\remarkname{Bemerkung}
\def\definitionname{Definition}
\def\exercisename{\"Ubung}
\def\examplename{Beispiel}
\def\examplesname{Beispiele}
\def\conjecturename{Vermutung}
\def\problemname{Problem}
\def\problemsname{Probleme}
\def\proofname{Beweis}
%\def\abstractname{Zusammenfassung}
\def\referencesname{Literatur}
}


%%%
%%% declaration of options %%%
%%%
\DeclareOption{editor}{
	\ClassInfo{artjlt}{Editor mode activated}
	\setboolean{editormode}{true}
	}

\DeclareOption{english}{
	\PassOptionsToPackage{\CurrentOption}{babel}
	\setboolean{languageset}{true}
	}
\DeclareOption{french}{
	\PassOptionsToPackage{\CurrentOption}{babel}
	\setboolean{languageset}{true}
	\AtBeginDocument{\frenchbsetup{AutoSpacePunctuation=false}}
	}
\DeclareOption{ngerman}{
	\PassOptionsToPackage{\CurrentOption}{babel}
	\setboolean{languageset}{true}
	}
\DeclareOption{german}{
	\PassOptionsToPackage{\CurrentOption}{babel}
	\setboolean{languageset}{true}
	}

%%%
%%% execution of options %%%
%%%

\ProcessOptions* \relax


%%%
%%% package loading %%%
%%%
\PassOptionsToClass{12pt,twoside,a4paper}{article}
\LoadClass{article}
\RequirePackage{color}
\RequirePackage{amsthm}

% default: ENGLISH captions
\ifthenelse{\boolean{languageset}}{}{\PassOptionsToPackage{english}{babel}}
\RequirePackage{babel}

% Hook up our extra captions
\addto\captionsenglish{\englishcaptions}
\addto\captionsfrench{\frenchcaptions}
\addto\captionsngerman{\germancaptions}
\addto\captionsgerman{\germancaptions}



%%
%%
%%
\def\lastname#1{\gdef\@lastname{#1}}
\def\@lastname{\@latex@warning@no@line{No \noexpand\lastname given}}

\def\msc#1{\gdef\@msc{#1}}
\def\@msc{\textcolor{red}{Mathematics Subject Classification missing}}
\def\keywords#1{\gdef\@keywords{#1}}
\def\@keywords{\textcolor{red}{Key Words and phrases missing}}

\def\volume#1{\gdef\@volume{#1}}
\def\@volume{??}
\def\annum#1{\gdef\@annum{#1}}
\def\@annum{??}
\def\issue#1{\gdef\@issue{#1}}
\def\@issue{??}
\def\editor#1{\gdef\@editor{#1}}
\def\@editor{??}

%% received date, final submission date

\def\received#1{\gdef\@received{#1}}
\def\@received{\@latex@warning@no@line{No \noexpand\received given}\textcolor{red}{No received date given}}
\def\final#1{\gdef\@final{#1}}
\def\@final{\@latex@warning@no@line{No \noexpand\final given}\textcolor{red}{No final date given}}

% Combine received and final date
\def\artjlt@recdate{\ifx\@received\@final
  {\footnotesize\baselineskip=0.8\baselineskip\noindent%
  Received \@received}
\else%
  \vbox{\footnotesize\baselineskip=0.8\baselineskip\noindent%
  Received \@received\\%
  and in final form \@final}
\fi}



%%
%% Manage author addresses.
%%
%% Author addresses are rendered in two columns, from left to right, top to
%% bottom. We use a counter 'artjlt@addresscounter' to keep track of how many
%% addresses were added, so that we can distinguish between the left and right
%% column.
%%
\newcounter{artjlt@addresscounter}

% The list of addresses is stored in \artjlt@addresses
\let\artjlt@addresses\@empty

% Add a new address.
% Appends the new address to \artjlt@addresses; also, for those with an even
% index (=left column), we insert a \bigskip afterwards.
%
\newcommand{\address}[1]{%
  \stepcounter{artjlt@addresscounter}
  \ifthenelse{\isodd{\theartjlt@addresscounter}}{%odd
    \g@addto@macro\artjlt@addresses{\par{}\vspace*{0.5cm}}
  }{%even
  }
  \g@addto@macro\artjlt@addresses{\address{#1}}
}

% Display addresses at end of document. Each address is inserted into its own
% minipage.
\AtEndDocument{
    \begingroup
    \par\noindent   
    \def\address#1{\begingroup
     \noindent%
     \begin{minipage}[t]{.4\hsize}%
     \footnotesize\baselineskip=0.8\baselineskip\parindent0pt\noindent%
     #1%
     \end{minipage}\qquad%
     \endgroup}%
    \artjlt@addresses
    \hfill\par{}\vskip.8truecm
  \endgroup
}


%%
%% Layout definitions
%%

\tolerance=300
\pretolerance=200
\hfuzz=1pt
\vfuzz=1pt
\parindent35pt
\mathsurround1pt
\parskip=1pt plus .25pt minus .25pt
%\baselineskip10.5pt
%\abovedisplayskip=10pt plus 2.5pt minus 7.5pt
%\abovedisplayshortskip=0pt plus 2.5pt
%\jot=2.5pt
\parsep0.0explus0.0exminus0.1ex
\topsep0.0explus0.0exminus0.1ex
\itemsep0explus0.2ex
\normallineskiplimit=1pt

\setlength{\topmargin}{-50pt}
\setlength{\evensidemargin}{22pt}
\setlength{\oddsidemargin}{22pt}
\addtolength{\textwidth}{14mm} 
%\addtolength{\textheight}{150pt}
\textheight = 46\baselineskip
\advance\textheight by \topskip

%
% Page heading
%
\def\ps@headings{\let\@mkboth\@gobbletwo
\def\@oddhead{\ifnum\value{page}=\value{artjlt@fpageno}\firstheadline
%              \typeout{*** Don't mind the following overfull vbox ! ***} 
              \else\rightheadline\rm\thepage\fi}
\def\@oddfoot{}
\def\@evenhead{\ifnum\value{page}=\value{artjlt@fpageno}\firstheadline
%              \typeout{*** Don't mind the following overfull vbox ! ***} 
              \else\rm\thepage\leftheadline\fi}
\def\@evenfoot{}
}
\pagestyle{headings}


%
% The next lines redefine the maketitle output
%

\renewcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    %  \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
    %\newpage
    %\null
    %\vskip 2em%
    \vbox{\vskip2.2truecm}%
    \begin{center}%
    \let \footnote \thanks%
     %\vbox{\vskip2.5truecm}
     % Insert the title, with somewhat increased line spacing
     {\boldmath\normalfont\bfseries\large\par{\@title}\vskip.8truecm}
     {\bf\@author\vskip.8truecm}
     \ifthenelse{\boolean{editormode}}
       {Communicated by \@editor\vskip.8truecm}
       {$ $\vskip.8truecm}
    \end{center}%
    %\par
    %\vskip 1.5em
    \@thanks
     \ifthenelse{\boolean{editormode}}
       {{\insert\footins{\vbox{\vglue1em\rm \noindent
                 ISSN 0949--5932 / \$2.50\quad \copyright\ Heldermann Verlag}}}
       }{}
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}


%%
%% The next lines redefine the abstract environment.
%% It now automatically inserts MSC and keywords at the end.
%%

\renewenvironment{abstract}
{\narrower\footnotesize\bf\noindent\abstractname.\quad\footnotesize\rm}
{\\
	{\sl Mathematics Subject Classification 2010:} \@msc.\\
	{\sl Key Words and Phrases:} \@keywords.
	\par\bigskip
}

% The next lines define how sectionheadlines are typed. For sectioning use
% the LaTeX command \section{...}. If you prefer to have sectionheads without
% numbering, use \section*{...}, but this does not increase the section 
% counter.

\def\@seccntformat#1{\csname the#1\endcsname.\quad}
\renewcommand{\section}{%
	\@startsection{section}{1}{\z@}%
	   {-0.8truecm}%
	   {\medskipamount}%
	   {\boldmath\normalfont\bfseries \centering}}

%%
%% 4-16-1999 SUBSECTION introduced by DIMI
%%

% Alte Form bis 7.4.2019:
% \newcounter{subs}[section]
% \def\subsection#1{\par\medskip\noindent%
% \stepcounter{subs}\bf\thesection.\arabic{subs}.~#1\quad\rm\ignorespaces}
% \newcounter{ssubs}[section]
% \def\subsubsection#1{\par\smallskip\noindent%
% \stepcounter{ssubs}\bf\thesection.\arabic{subs}.\arabic{ssubs}.~#1\quad\rm\ignorespaces}

% Neue Form von Ulrike Fischer ab 8.4.2019

\newcounter{subs}[section]
\setcounter{subs}{1}
\def\subsection#1{\par\medskip\noindent%
\refstepcounter{subs}\bf\thesection.\arabic{subs}.~#1\quad\rm\ignorespaces}
\renewcommand\thesubs{\thesection.\arabic{subs}}

\newcounter{ssubs}[section]
\setcounter{ssubs}{1}
\def\subsubsection#1{\par\smallskip\noindent%
\refstepcounter{ssubs}\bf\thesection.\arabic{subs}.\arabic{ssubs}.~#1\quad\rm\ignorespaces}
\renewcommand\thessubs{\thesubs.\arabic{ssubs}}%


%%
%%  BIBLIOGRAPHY MACROS
%%

% \nextref{<label>}{<author>}{<title>}{<where published>}
\newcommand{\nextref}[4]{\bibitem{#1} {#2}, {#3}, {#4}.}

% Redefine thebibliography to left-align the labels.
\let\artjlt@thebibliography\thebibliography
\def\thebibliography#1{%
  \artjlt@thebibliography{#1}%
  \def\artjlt@biblabel##1{##1\hfill}%
  \let\makelabel\artjlt@biblabel
  }


%%
%% Theorem styles and environments as well as the Proof environment,
%% 

% Redefine the proof environment (we want "Proof" to be in bold).
\let\JoLT@old@proof\proof
\def\proof{\begin}
\def\proof{\@ifnextchar[\proof@i \proof@ii}
\def\proof@i[#1]{\JoLT@old@proof[{\bf #1}]\quad}
\def\proof@ii{\JoLT@old@proof[{\bf \proofname}]\quad}

% Alias proof -> Proof
\newenvironment{Proof}{\begin{proof}}{\end{proof}}

% Custom theorem styles
\newtheoremstyle{joltthm}% name
 {\baselineskip}%      Space above
 {\baselineskip}%      Space below
 {\itshape}%         Body font
 {}%         Indent amount (empty = no indent, \parindent = para indent)
 {\bfseries}% Thm head font
 {.}%        Punctuation after thm head
 {1.5em}%     Space after thm head: " " = normal interword space;
	   %       \newline = linebreak
 {}%         Thm head spec (can be left empty, meaning `normal')

\newtheoremstyle{joltdefn}% name
 {\baselineskip}%      Space above
 {\baselineskip}%      Space below
 {}%         Body font
 {}%         Indent amount (empty = no indent, \parindent = para indent)
 {\bfseries}% Thm head font
 {.}%        Punctuation after thm head
 {1.5em}%     Space after thm head: " " = normal interword space;
	   %       \newline = linebreak
 {}%         Thm head spec (can be left empty, meaning `normal')


%
% Theorem and similar environments
%

\theoremstyle{joltthm}
\newtheorem{Theorem}{\theoremname}[section]
\newtheorem{Proposition}[Theorem]{\propositionname}
\newtheorem{Corollary}[Theorem]{\corollaryname}
\newtheorem{Lemma}[Theorem]{\lemmaname}
%% USE \begin{Remark} FOR REMARKS

\theoremstyle{joltdefn}
\newtheorem{Remark}[Theorem]{\remarkname}
\newtheorem{Definition}[Theorem]{\definitionname} %% write
\newtheorem{Exercise}[Theorem]{\exercisename}
\newtheorem{Example}[Theorem]{\examplename}
\newtheorem{Examples}[Theorem]{\examplesname}
\newtheorem{Conjecture}[Theorem]{\conjecturename}
\newtheorem{Problem}[Theorem]{\problemname}
\newtheorem{Problems}[Theorem]{\problemsname}


% Variants of the theorem environments in lower case, for sake of editing convenience

\newenvironment{theorem}{\begin{Theorem}}{\end{Theorem}}
\newenvironment{proposition}{\begin{Proposition}}{\end{Proposition}}
\newenvironment{corollary}{\begin{Corollary}}{\end{Corollary}}
\newenvironment{lemma}{\begin{Lemma}}{\end{Lemma}}
\newenvironment{remark}{\begin{Remark}}{\end{Remark}}
\newenvironment{example}{\begin{Example}}{\end{Example}}
\newenvironment{exercise}{\begin{Exercise}}{\end{Exercise}}
\newenvironment{exercises}{\begin{Exercises}}{\end{Exercises}}
\newenvironment{problem}{\begin{Problem}}{\end{Problem}}
\newenvironment{problems}{\begin{Problems}}{\end{Problems}}
\newenvironment{conjecture}{\begin{Conjecture}}{\end{Conjecture}}


% This is the end-of-proof sign, for internal use of amsthm only.
% Do not invoke this directly. If you want to conclude a proof at
% the end of a line in display mode use \qedhere !
\renewcommand{\qedsymbol}{\vrule height 1.2ex width 1.1ex depth -.1ex\relax}



%%%
%%% Editor mode macros: Counting of pages via pcount.tex
%%%

\newcounter{artjlt@fileno}
\setcounter{artjlt@fileno}{1}
\newcounter{artjlt@fpageno}
\setcounter{artjlt@fpageno}{1}
\newcounter{artjlt@lpageno}
\setcounter{artjlt@lpageno}{1}
\newcommand{\artjlt@filenr}{{}}
\newcommand{\artjlt@fpagenr}{{}}
\newcommand{\artjlt@lpagenr}{{}}
\newcommand{\artjlt@commence}{
	\newread\artjlt@file
	\openin\artjlt@file=pcount
    \read\artjlt@file to\artjlt@filenr
    \read\artjlt@file to\artjlt@fpagenr
    \read\artjlt@file to\artjlt@lpagenr  
    \closein\artjlt@file
    \setcounter{artjlt@fileno}{\number\artjlt@filenr}
    \setcounter{artjlt@fpageno}{\number\artjlt@fpagenr}
    \setcounter{artjlt@lpageno}{\number\artjlt@lpagenr}
    \addtocounter{artjlt@fileno}{1}
    \ifodd\value{artjlt@fileno}\addtocounter{artjlt@fpageno}{1}\fi
    \setcounter{page}{\value{artjlt@fpageno}}}
\newcommand{\artjlt@terminate}{\setcounter{artjlt@lpageno}{\thepage}
    \ifodd\value{artjlt@fileno}
    \else\ifodd\value{artjlt@lpageno}\addtocounter{artjlt@lpageno}{1}\fi\fi
	\newwrite\artjlt@file
    \openout\artjlt@file=pcount
    \write\artjlt@file{\theartjlt@fileno}
    \ifodd\value{artjlt@fileno}\write\artjlt@file{\theartjlt@fpageno}\else\write\artjlt@file{\theartjlt@lpageno}\fi
    \write\artjlt@file{\theartjlt@lpageno}
    \closeout\artjlt@file}


%%

\ifthenelse{\boolean{editormode}}
  {% if true
    \typeout{editor mode}
    \newcommand{\artjlt@pages}{\theartjlt@fpageno--\theartjlt@lpageno} 
    \AtBeginDocument{\artjlt@commence}
    \AtEndDocument{\artjlt@recdate}
    \AtEndDocument{\artjlt@terminate}
  }{% if false
    \typeout{regular mode}
    \newcommand{\artjlt@pages}{??--??}
  }

%%%%%%% END COUNTING MACROS FOR THE EDITOR %%%%%%


% TODO:

% Minor stuff
% * bigger line spacing in title (DONE)
% * \editor, \rec, \fin in template? maybe typeset in red in output if missing... (DONE)
% * add \issue command (DONE)

% Docs:
% * document english/french/german in guide (DONE)
% * verify keywords & msc are properly documented (DONE)

% Other:
% * 'revised' was used if \final equals \received -> get rid of it (DONE)
% * \address: ensure vertical alignments (DONE)
% * \qedhere und eqnarray ??? \tag does not work there...
% * bibliography: item numbers left aligned (maybe bigger spacing) (DONE)

% Bigger project:
% * generate 'abstract' files automatically


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Local Variables: 
%%% mode: latex 
%%% End:
