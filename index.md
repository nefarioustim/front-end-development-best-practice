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

### Use HTML not XHTML

Always use HTML instead of XHTML. Whilst the well-formed nature of XHTML is certainly attractive to the markup purist, there are many reasons not to use it:

 *  To display correctly in IE, XHTML must be served with the incorrect mime-type.
 *  IE's support of XHTML can be described as "buggy" at best.
 *  `document.write` is unsupported in XHTML.
 *  `iframes` are not supported in XHTML.

In the brave new world of [HTML as a living standard](http://whatwg.org/html), the correct DOCTYPE to use is as follows:

{% highlight html %}
<!DOCTYPE html>
{% endhighlight %}

Short and sweet. This DOCTYPE is supported in all modern browsers and will enforce standards compliance in IE9, IE8, and IE7.

<h2 id="presentation">Presentation</h2>

<h2 id="dynamic-behaviour">Dynamic Behaviour</h2>

<h2 id="accessibility">Accessibility</h2>

### Use links and input buttons for clickable elements

Links and buttons are focusable and activatable by default in a browser, which means they are perceivable and operable to screen reader users and keyboard-only users. Rich JavaScript widgets (like video player controls) should be progressively enhanced on-top of elements that, by default, are already accessible.


<h2 id="seo">Search Engine Optimisation</h2>