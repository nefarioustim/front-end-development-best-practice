---
title:      "Front End Development Best Practice"
layout:     index
---

Front End Development Best Practice
===================================

This document is a set of standards, best practices, and guidelines for front
end development. This documentation has been collated through many years
experience by a multitude of front end developers, front end architects, and
front end development managers.

<h2 id="semantic-markup">Semantic Markup</h2>

{% highlight html %}
<!DOCTYPE html>
<html lang="en-GB">
    <head>
        <meta charset="utf-8">
        <title>Page title — Site title</title>
        <link rel="stylesheet" href="core.css">
    </head>
    <body>
        <div id="accessibility">
            <a href="#main-content">Skip to content</a>
        </div>
    
        <header role="banner">
            <div class="masthead">
                Site title
            </div>
            <nav id="nav" role="navigation">
                <ul>
                    <li><a href="/">Home</a></li>
                </ul>
            </nav>
        </header>
    
        <section id="main-content" role="main">
            <h1>Page title</h1>
        
        </section>
    
        <footer>
            © 2011 <a href="http://timhuegdon.com/" rel="me">Tim Huegdon</a>
        </footer>
    </body>
</html>
{% endhighlight %}

<h2 id="presentation">Presentation</h2>

<h2 id="dynamic-behaviour">Dynamic Behaviour</h2>

<h2 id="accessibility">Accessibility</h2>

<h2 id="seo">Search Engine Optimisation</h2>