%% Esta clase corresponde a una versión alpha de la clase original. 
%%
%% En esta versión se incluyó: 
%%     - Soporte para sub sub secciones y estilos de sección no numerados. 2021-05-01
%% 
%% Copyright (C) 2020 by Andres Merino <mat.andresmerino@gmail.com>
%% 
%% Para un mejor uso y entendimiento de la actual clase,
%% consultar la documentación.
%% 
\NeedsTeXFormat{LaTeX2e}[2009/09/24]
\ProvidesClass{aleph-notas}[2020/08/14 v1.1]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --- Inicialización
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Primero definimos una serie de comandos auxiliares para las opciones
\newcommand\@idioma{spanish,es-noitemize}
\newcommand\@tipo{}
\RequirePackage{ifthen}
\newboolean{comentarios}\setboolean{comentarios}{false}
\newboolean{codigo}\setboolean{codigo}{false}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --- Opciones
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Opciones de tamaño de letra.
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{article}}
%%  Opciones predeterminadas de tamaño de página |compacto| y |amplio|.
\DeclareOption{amplio}{
    \PassOptionsToPackage{paperwidth=195mm,paperheight=265mm,twoside,
    inner=2.2cm,outer=2.2cm,top=2.25cm,bottom=2.25cm}{geometry}}
\DeclareOption{compacto}{
    \PassOptionsToPackage{paperwidth=160mm,paperheight=240mm,twoside,
    inner=1.7cm,outer=1.7cm,top=2.25cm,bottom=2.25cm}{geometry}}
\DeclareOption{a4}{
    \PassOptionsToPackage{paperwidth=210mm,paperheight=297mm,twoside,
    inner=2.2cm,outer=2.2cm,top=2.25cm,bottom=2.25cm}{geometry}}
\DeclareOption{a5}{
    \PassOptionsToPackage{paperwidth=148mm,paperheight=210mm,twoside,
    inner=1.7cm,outer=1.7cm,top=2.25cm,bottom=2.25cm}{geometry}}
%%  Opción de formato |fclasico| o |fnuevo|.
\DeclareOption{fclasico}{\renewcommand\@tipo{fclasico}}
\DeclareOption{fnuevo}{\renewcommand\@tipo{fnuevo}}
%%  Opción para desplegar comentarios
\DeclareOption{comentarios}{\setboolean{comentarios}{true}}
%%  Opción para desplegar códigos
\DeclareOption{codigo}{\setboolean{codigo}{true}}
%%  Opciones predeterminadas son |compacto|, |fclasico| y |10pt|.
\ExecuteOptions{compacto,fclasico,10pt}
\ProcessOptions\relax
\LoadClass{article}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --- Paquetes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Son necesarios los siguientes paquetes para dar 

al documento.
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[\@idioma]{babel}
\RequirePackage{calc}
\RequirePackage{etex}
\RequirePackage{xcolor}
\RequirePackage{amsmath,amsthm}
\RequirePackage{mdframed}
\RequirePackage[many]{tcolorbox}
\RequirePackage{fontawesome}
\RequirePackage{mathpazo}
\RequirePackage{graphicx}
\RequirePackage{titlesec}
\RequirePackage{setspace}
\RequirePackage{fancyhdr}
\RequirePackage{titletoc}
\RequirePackage{comment}
\RequirePackage[many]{tcolorbox}
\RequirePackage[font={small},labelfont={bf,small},
   justification=centerlast]{caption}
\RequirePackage{float}
\RequirePackage{geometry}
\RequirePackage[colorlinks,linkcolor=black,urlcolor=black,
   citecolor=black,bookmarks=true]{hyperref}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --- Variables internas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  La siguiente es la lista de las variables internas utilizadas para el formato.
\newcommand\@universidad{Escuela Politécnica Nacional}
\newcommand\@longtitulo{0.75\linewidth}
\newcommand\@interlineado{1.2}
\newcommand\@espteo{-0.75ex}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --- Colores predeterminados
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Los siguientes son los colores predefinidos de la clase.
\definecolor{colordef}{cmyk}{0.81,0.62,0.00,0.22}
\definecolor{colortext}{cmyk}{0.81,0.62,0.00,0.22}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --- Espaciado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Para mejorar la medida entre las ecuaciones.
\AtBeginDocument{
   \addtolength{\abovedisplayskip}{-0.5mm}
   \addtolength{\belowdisplayskip}{-0.5mm}
    }
%%  Interlineado
\newcommand{\interlineado}[1]{\renewcommand\@interlineado{#1}}
%%  Espacio para recuadro de teoremas
\newcommand{\espteo}[1]{\renewcommand\@espteo{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --- Definición de comandos de datos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Universidad
\newcommand{\universidad}[1]%
    {\renewcommand\@universidad{#1}}
%%  Autor: autor corto, autor normal
\newcommand{\autor}[2][]{\ifthenelse{\equal{#1}{}}
   {\newcommand\@autorcorto{#2}\newcommand\@autor{#2}}
   {\newcommand\@autorcorto{#1}\newcommand\@autor{#2}}}
%%  Materia
\newcommand{\materia}[1]%
    {\newcommand\@materia{#1}}
%%  Examen
\newcommand{\nota}[1]%
    {\newcommand\@nota{#1}}
%%  Tema
\newcommand{\tema}[1]%
    {\newcommand\@tema{ #1}}
%%  Fecha
\newcommand{\fecha}[1]%
    {\newcommand\@fecha{#1}}
%%  Logo uno
\newcommand{\logouno}[2][0.1\linewidth]%
    {\newcommand\@logouno{#2}
    \newcommand\@longlogouno{#1}}
%%  Logo dos
\newcommand{\logodos}[2][0.1\linewidth]%
    {\newcommand\@logodos{#2}
    \newcommand\@longlogodos{#1}}
%%  Longitud del título
\newcommand{\longtitulo}[1]%
    {\renewcommand\@longtitulo{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --- Encabezado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Comando para generar el título
\newcommand\@titulo{
    \large\textbf{\textsc{\@universidad\\
    \ifthenelse{\isundefined{\@hoja}}{}{\@hoja\\}
    \normalsize
    \@materia\ \ $\bullet$\ \
    \@nota}}\\
    \ifthenelse{\isundefined{\@tema}}{}{\normalsize\textsc{\@tema}\\}
    }
\newcommand\@inlogouno{
    \parbox{\@longlogouno}
    {\centering
    \ifthenelse{\isundefined{\@logouno}}{\hspace{0pt}}
        {\includegraphics[width=0.95\linewidth]{\@logouno}}}
    }
\newcommand\@inlogodos{
    \parbox{\@longlogodos}
    {\centering
    \ifthenelse{\isundefined{\@logodos}}{\hspace{0pt}}
        {\includegraphics[width=0.95\linewidth]{\@logodos}}}
    }
%%  Comando para generar el encabezado
\newcommand{\encabezado}{
    \vspace*{-10mm}
    \begingroup\color{colortext}
    \thispagestyle{plain}
    \noindent
    \begin{minipage}{0.999\linewidth}
    \begin{center}
    \hrule
    \vspace{2mm}
    \ifthenelse{\isundefined{\@logodos}}
        {\ifthenelse{\isundefined{\@logouno}}
            {\@titulo}
            {
                \@inlogouno
                \parbox{\@longtitulo}{\centering \@titulo}
            }
        }
        {
            \@inlogouno
            \parbox{\@longtitulo}{\centering \@titulo}
            \@inlogodos
        }
    \end{center}
    \vspace{0mm}
    \noindent
    \@fecha\hspace{\fill}
    \@autor\\[-3mm]
    \hrule
    \end{minipage}
    \endgroup
    \vspace{5mm}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --- Estilo página
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Interlineado
\renewcommand{\baselinestretch}{\@interlineado}
%%  Encabezado y pie de página
\pagestyle{fancy}
\fancyhf{}
\fancyfoot[C]{\thepage}
\fancyhead[LE,RO]{\bfseries\@autorcorto}
\fancyhead[LO,RE]{\bfseries\@nota}
\renewcommand{\headrulewidth}{.2pt}
\renewcommand{\footrulewidth}{0pt}
\addtolength{\headheight}{.1pt}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --- Estilo títulos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Estilo de sección
\titleformat{\section}[display]
    {\vspace*{-2mm}\bfseries\scshape\centering}
    {}{1ex}
    {\color{colortext}\large\titlerule\vspace{.05ex}
    \thesection.\ }
    [\color{colortext}\vspace{.2ex}\titlerule]
%%  Estilo de secciones no numeradas
\titleformat{name=\section,numberless}[display]
  {\vspace*{-2mm}\bfseries\scshape\centering}
    {}{1ex}
    {\color{colortext}\large\titlerule\vspace{.05ex}
     }
    [\color{colortext}\vspace{.2ex}\titlerule]
%%  Estilo subsecciones
\titleformat{\subsection}
    {\color{colortext}\normalsize\bfseries}
    {\thesubsection}{1em}{}
%%  Estilo de subsubsecciones
\titleformat{\subsubsection}
    {\color{colortext}\normalsize\bfseries}
    {\thesubsubsection}{1em}{}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --- Estilo teoremas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Keys temporales: |tipo|,|color|, |contador| e |icóno|.
\def\tcb@@tipo{}
    \tcbset{ tipo/.code = {\def\tcb@@tipo{#1} } }
\def\tcb@@contador{}
    \tcbset{ contador/.code = {\def\tcb@@contador{#1} } }
\def\tcb@@color{colordef}
    \tcbset{ color/.code = {\def\tcb@@color{#1} } }
\def\tcb@@icono{{\large\faWarning}}
    \tcbset{ icono/.code = {\def\tcb@@icono{#1} } }
%%  Estilo de teorema clásico
\newtheoremstyle{estiloteorema}%
    {9pt}{9pt}{}{0pt}{\bfseries\scshape}{.}{ }{}
%%  Estilo de teorema nuevo
\newtheoremstyle{estiloteoreman}%
    {9pt}{9pt}{}{0pt}{\bfseries\sffamily\color{\tcb@@color}}{}{ }{\thmname{#1}\thmnumber{ #2}.\thmnote{ --#3--}}
%%  Formatos del estilo clásico
%%
%%  Recuadro sin título aparte
\tcbset{ recuadrost/.style ={
    before skip=10pt,arc=0mm,breakable,enhanced,
    colback=\tcb@@color!5,colframe=\tcb@@color,
    boxrule=0pt,leftrule=2pt,
    top=0.5mm,bottom=0.5mm,left=2mm,right=2mm,
    fontupper=\normalsize,
    parbox=false
    }
    }
%%  Escritura del título
\newcommand\tbc@escrituratitulo[1][]{%
    \strut{%
        \bfseries\scshape\tcb@@tipo~\arabic{\tcb@@contador}%
            \ifthenelse{\equal{#1}{}}{}{:\upshape~#1}%
        }
    }
%%  Dibujo del título a la izquierda
\newcommand\tbc@dibujotituloizq[1][]{%
    % Creación del nombre para medirlo
    \node[xshift=13pt,yshift=\@espteo,thick,anchor=west](titulo) at (frame.north west)%
        {\tbc@escrituratitulo[#1]};
    % Sombra del recuadro
    \path[fill=\tcb@@color!60!black]
        ([yshift=-1.75ex,xshift=-0.1ex]titulo.north west)
        arc[start angle=0,end angle=180,radius=0.9ex]
        ([yshift=-1.75ex,xshift=0.1ex]titulo.north east)
        arc[start angle=180,end angle=0,radius=0.9ex];
    % Recuadro
    \path[fill=\tcb@@color!20]
        % Linea superior
        ([xshift=-0.9ex,yshift=-0.85ex]titulo.north west)
        -- ([xshift=0.9ex,yshift=-0.85ex]titulo.north east)
        % Linea inferior
        [rounded corners=0.7ex]  --  ([xshift=0.4ex,yshift=-0.95ex]titulo.north east)--
        ([yshift=0.6ex]titulo.south east) -- ([yshift=0.6ex]titulo.south west)
        % Ciclo
        --  ([xshift=-0.4ex,yshift=-0.95ex]titulo.north west)
        [sharp corners] -- cycle;
    % Escritura del nombre
    \node[xshift=13pt,yshift=-0.8ex,thick,anchor=west] at (frame.north west)%
        {\tbc@escrituratitulo[#1]};
    }
%%  Recuadro con título aparte a la izquierda
\tcbset{ recuadroctizq/.style ={
    % Opciones generales
    before skip=10pt,arc=0mm,breakable,enhanced,
    colback=\tcb@@color!5,colframe=\tcb@@color,
    boxrule=0pt,leftrule=2pt,
    top=4mm,bottom=0.5mm,left=2mm,right=2mm,
    topsep at break=-4mm,
    fontupper=\normalsize,
    code={\refstepcounter{\tcb@@contador}},
    parbox=false,
    % Dibujo del título
    overlay unbroken and first = {\tbc@dibujotituloizq[#1]}
    }
    }
%%  Dibujo del título a la derecha
\newcommand\tbc@dibujotituloder[1][]{%
    % Creación del nombre para medirlo
    \node[xshift=-13pt,yshift=\@espteo,thick,anchor=east](titulo) at (frame.north east)%
        {\tbc@escrituratitulo[#1]};
    % Sombra del recuadro
    \path[fill=\tcb@@color!60!black]
        ([yshift=-1.75ex,xshift=-0.1ex]titulo.north west)
        arc[start angle=0,end angle=180,radius=0.9ex]
        ([yshift=-1.75ex,xshift=0.1ex]titulo.north east)
        arc[start angle=180,end angle=0,radius=0.9ex];
    % Recuadro
    \path[fill=\tcb@@color!20]
        % Linea superior
        ([xshift=-0.9ex,yshift=-0.85ex]titulo.north west)
        -- ([xshift=0.9ex,yshift=-0.85ex]titulo.north east)
        % Linea inferior
        [rounded corners=0.7ex]  --  ([xshift=0.4ex,yshift=-0.95ex]titulo.north east)--
        ([yshift=0.6ex]titulo.south east) -- ([yshift=0.6ex]titulo.south west)--
        % Ciclo
        ([xshift=-0.4ex,yshift=-0.95ex]titulo.north west)
        [sharp corners] -- cycle;
    % Escritura del nombre
    \node[xshift=-13pt,yshift=-0.8ex,thick,anchor=east] at (frame.north east)%
        {\tbc@escrituratitulo[#1]};
    }
%%  Recuadro con título aparte a la derecha
\tcbset{ recuadroctder/.style ={
    % Opciones generales
    before skip=10pt,arc=0mm,breakable,enhanced,
    colback=\tcb@@color!5,colframe=\tcb@@color,
    boxrule=0pt,leftrule=2pt,
    top=4mm,bottom=0.5mm,left=2mm,right=2mm,
    topsep at break=-4mm,
    fontupper=\normalsize,
    code={\refstepcounter{\tcb@@contador}},
    parbox=false,
    % Dibujo del título
    overlay unbroken and first= {\tbc@dibujotituloder[#1]}
    }
    }
%%  Estilo de post-it
\tcbset{ postit/.style ={
    % -> Opciones generales
    breakable,enhanced,
    before skip=2mm,after skip=3mm,
    colback=\tcb@@color!50,colframe=\tcb@@color!20!black,
    boxrule=0.4pt,
    drop fuzzy shadow,
    left=6mm,right=2mm,top=0.5mm,bottom=0.5mm,
    sharp corners,rounded corners=southeast,arc is angular,arc=3mm,
    parbox=false,
    underlay unbroken and last = {%
        \path[fill=tcbcolback!80!black]
        ([yshift=3mm]interior.south east) --++ (-0.4,-0.1) --++ (0.1,-0.2);
        \path[draw=tcbcolframe,shorten <=-0.05mm,shorten >=-0.05mm]
        ([yshift=3mm]interior.south east) --++ (-0.4,-0.1) --++ (0.1,-0.2);
        \path[fill=\tcb@@color!50!black,draw=none]
        (interior.south west) rectangle node[white]{\tcb@@icono} ([xshift=5.5mm]interior.north west);
        },
    underlay = {%
        \path[fill=\tcb@@color!50!black,draw=none]
        (interior.south west) rectangle node[white]{\tcb@@icono} ([xshift=5.5mm]interior.north west);
        }
    }
    }
%%  Formatos del estilo nuevo
%%
%%  Recuadro con título aparte interno
\tcbset{ recuadroctint/.style ={
    % -> Opciones generales
    before skip=10pt,arc=0mm,breakable,enhanced,
    colback=gray!5,colframe=gray!5,colbacktitle=gray!5,
    boxrule=0pt,toprule=0.4pt,
    drop fuzzy shadow,
    top=0.5mm,bottom=0.5mm,left=2mm,right=2mm,
    fontupper=\normalsize,
    code={\refstepcounter{\tcb@@contador}},
    parbox=false,
    % Dibujo del título
    overlay unbroken and first = {
        % Borde superior grueso
        \draw[\tcb@@color,line width =2.5cm]
            ([xshift=1.25cm, yshift=0cm]frame.north west)--+(0pt,3pt);
        },
    overlay middle and last = { },
    title={
            \bfseries\sffamily\color{\tcb@@color}
                \tcb@@tipo~\arabic{\tcb@@contador}%
                \ifthenelse{\equal{#1}{}}{}{:~~--#1--}%
        },
    }
    }
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --- Definición de ambientes de teoremas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --- Teoremas en el formato clásico
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifthenelse{\equal{\@tipo}{fclasico}}
{
%%  Ambientes sin recuadro: |ejem| y |obs|
\theoremstyle{estiloteorema}
    \newtheorem{ejem}{Ejemplo}
    \newtheorem*{obs}{Observaci\'on}
%%  Ambientes con recuadrost: |prop|, |cor|, |lem|, |ejer|.
    \newtheorem{prop}{Proposici\'on}
        \tcolorboxenvironment{prop}{color=colordef,recuadrost}
    \newtheorem{cor}[prop]{Corolario}
        \tcolorboxenvironment{cor}{color=colordef,recuadrost}
    \newtheorem{lem}[prop]{Lema}
        \tcolorboxenvironment{lem}{color=colordef,recuadrost}
    \newtheorem{ejer}{Ejercicio}
        \tcolorboxenvironment{ejer}{color=colordef,recuadrost}
%%  Ambientes con título aparte: |teo|.
\newtcolorbox{teo}[1][]
    {tipo=Teorema,contador=prop,color=colordef,recuadroctizq={#1}}
%%  Ambientes con título aparte: |defi|.
\newcounter{defi}
\renewcommand{\thedefi}{\arabic{defi}}
\newtcolorbox{defi}[1][]
    {tipo=Definición,contador=defi,color=colordef,recuadroctizq={#1}}
%%  Ambientes con título aparte: |axioma|.
\newcounter{axioma}
\renewcommand{\theaxioma}{\arabic{axioma}}
\newtcolorbox{axioma}[1][]
    {tipo=Axioma,contador=axioma,color=colordef,recuadroctizq={#1}}
%%  Ambientes advertencia: |advertencia|.
\newtcolorbox{advertencia}
    {color=yellow,postit}
}
{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --- Teoremas en el formato nuevo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Ambientes sin recuadro: |ejem| y |obs|
\theoremstyle{estiloteoreman}
    \newtheorem{ejem}{Ejemplo}
    \newtheorem*{obs}{\tikz \fill[colordef] (1ex,1ex) circle (3.5pt); Observaci\'on}
%%  Ambientes con recuadrost: |prop|, |cor|, |lem|, |ejer|.
    \newtheorem{prop}{Proposici\'on}
        \tcolorboxenvironment{prop}{%
            color=colordef,recuadrost,colback=gray!5,drop fuzzy shadow
        }
    \newtheorem{cor}[prop]{Corolario}
        \tcolorboxenvironment{cor}{%
            color=colordef,recuadrost,colback=gray!5,drop fuzzy shadow
        }
    \newtheorem{lem}[prop]{Lema}
        \tcolorboxenvironment{lem}{%
            color=colordef,recuadrost,colback=gray!5,drop fuzzy shadow
        }
    \newtheorem{ejer}{Ejercicio}
        \tcolorboxenvironment{ejer}{%
            color=colordef,recuadrost,colback=gray!5,drop fuzzy shadow
        }
%%  Ambientes con título aparte: |teo|.
\newtcolorbox{teo}[1][]
    {tipo=Teorema,contador=prop,color=colordef,recuadroctint={#1}}
%%  Ambientes con título aparte: |defi|.
\newcounter{defi}
\renewcommand{\thedefi}{\arabic{defi}}
\newtcolorbox{defi}[1][]
    {tipo=Definici\'on,contador=defi,color=colordef,recuadroctint={#1}}
%%  Ambientes con título aparte: |axioma|.
\newcounter{axioma}
\renewcommand{\theaxioma}{\arabic{axioma}}
\newtcolorbox{axioma}[1][]
    {tipo=Axioma,contador=axioma,color=colordef,recuadroctint={#1}}
%%  Ambientes advertencia: |advertencia|.
\newtcolorbox{advertencia}
    {color=yellow,postit}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --- Ambiente opcionales
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Estilo de comentarios para el docente
\ifthenelse{\boolean{comentarios}}{
    \newtcolorbox{comentarios}{
        breakable,
        enhanced,
        outer arc=0pt, arc=0pt,
        colframe=colordef!20,
        colback=white,
        attach boxed title to top left,
        boxed title style={
            colback=colordef!50,
            outer arc=0pt, arc=0pt,
            boxrule=0pt,
        },
        boxrule=0pt,
        borderline west = {1.5pt}{0pt}{colordef!50},
        borderline south = {1.5pt}{0pt}{colordef!50},
        left=1mm,
        fontlower=\small,
        title=\textbf{\textsc{\small \textcolor{black}{Sugerencias metodológicas:}}}
        }
    }
    {\excludecomment{comentarios}}
%%  Estilo de código para el docente
\ifthenelse{\boolean{codigo}}{
    \newtcolorbox{codigo}{
    blanker,breakable, left=3mm, before skip=10pt, after skip=10pt, borderline west={1mm}{0pt}{colordef!50}, fontlower=\small}
    }
    {\excludecomment{codigo}}
%%  Y ¡se acabó!
\endinput
%%
%% End of file `aleph-notas.cls'.
