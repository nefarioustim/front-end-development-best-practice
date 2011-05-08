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

In the brave new world of [HTML as a living standard](http://whatwg.org/html), the correct `DOCTYPE` to use is as follows:

{% highlight html %}
<!DOCTYPE html>
{% endhighlight %}

### No whitespace before the `DOCTYPE`

### Semantic element identifiers

<h2 id="browsers">Browsers</h2>

### Baseline browser support

A-Grade experience: Test, and ensure that the visitor gets a first-class browsing and interaction experience in the following browsers:

* Internet Explorer 7+ (on Windows)
* Mozilla Firefox 3.6+ (on OSX and Windows)
* Chrome 5+ (on OSX and Windows)
* Safari 5+ (on OSX)
* Opera 10+ (on Windows)

This doesn't mean the pages have to be pixel-perfect between browsers, but as close as reasonably possible to the design requirement with all of the functionality and interactivity working perfectly.

Test, and ensure that the visitor gets a useable and not-obviously-broken experience with:

* Internet Explorer 6
* Safari 4

Other browser support matrixes are available, such as [YUI Graded Browser Support](http://developer.yahoo.com/yui/articles/gbs/), the [BBC Browser Support Standards](http://www.bbc.co.uk/guidelines/futuremedia/technical/browser_support.shtml#support_table), and [jQuery Browser Compatibility](http://docs.jquery.com/Browser_compatibility).


### Use server-side browser detection and add classes

Avoid client-side libraries such as [modernizr](http://www.modernizr.com/) which pollutes your markup with non-semantic element identifiers.

<h2 id="presentation">Presentation</h2>

### Use CSS3 presentation effects over old presentation hacks

The following effects can be done in CSS3, with no fallback when not supported in browsers (like Internet Explorer 6 & 7):

* Rounded corners with `border-radius`
* Gradient backgrounds with `background: gradient` and `background: linear-gradient`. Where possible, and when it causes no adverse effects use Microsoft's group of filters to add gradients for Internet Explorer. Also supply an appropriate default fallback background colour.
* Box shadows with `box-shadow`

Don't forget to add vendor-specific style properties where necessary.

### Use CSS hacks to work around Internet Explorer CSS issues

Where Internet Explorer 6 and 7 need extra style rules to create a non-broken browsing experience, use the underscore and/or star hacks to create IE-specific style rules. Use CSS comments to document the use of CSS hacks. 

{% highlight css %}
.module {
	float: left;
	_display: inline; /* Double margin fix for IE6 */
}
{% endhighlight %}

Keep these CSS hacks as close as possible to the rest of the styles that affect the same selector. Don't separate them into a separate IE-only stylesheet, since they will be overlooked and forgotten when the main style rules change.

### Use overflow to self-clear contained floats

Where possible use `overflow` on the containing element to clear floated elements.

{% highlight css %}
.module {
	overflow: hidden;
}
{% endhighlight %}

Where content inside of this container needs to spill out of the containing div (for example a dropdown menu near the bottom of the container), then use the content after method of clearing (using `zoom: 1` for Internet Explorer):

{% highlight css %}
.editing-panel {
	overflow: visible /* To unset a previous style-rule */
	_zoom: 1; /* self-clearing for IE */
}
.editing-panel:after {
	content: '.';
	display: block;
	clear: both;
	height: 0;
	visibility: hidden;
}
{% endhighlight %}

<h2 id="dynamic-behaviour">Dynamic Behaviour</h2>

### Add an `enhanced` class to modules or widgets

Where possible.

Otherwise…

### Add a `js` class when JavaScript is available


<h2 id="jquery">jQuery</h2>


### Use element names when selecting by class names

In jQuery lookups for elements with a specific class where possible use an element name as part of the selector. So instead of :

{% highlight javascript %}
var $todoItems = $('.todo');
{% endhighlight %}

Specify an element name in the selector:

{% highlight javascript %}
var $todoItems = $('li.todo');
{% endhighlight %}

Under the bonnet browsers that don't have a native `document.getElementsByClassName()` method, will use a `document.getElementsByTagName()` method with the element name instead of a `*`. This will return a smaller Node list and thus be quicker.


### Use references instead of repetitive DOM lookups

If you are doing some non-trivial work with a particular jquery wrapped set, store the wrapped set as a reference so that you can avoid recalculating the same wrapped set over and over. This approach also allows breaking down the code into easier to digest and understandable chunks.

Also to make it more obvious that we have a reference to a jQuery wrapped set prefix the reference variable with a `$`.

{% highlight javascript %}
var $items = $('ul.checklist li');

if ($items.length) {
	$('span.total').text($items.length);
	$items.filter('.done').remove();
}
{% endhighlight %}


### Break chained methods over multiple lines for readability

Although chaining is a useful feature of jQuery, it's too easy to create unreadable code. So be generous on the use of spacing and linebreaks and aim to make the code as readable as possible.

{% highlight javascript %}
	$('form.signup')
		.bind('submit', formSubmitHandler)
		.bind('validate.form', validateFormHandler)
		.bind('save.form', saveFormHandler)
		.removeClass('disableSubmit');
{% endhighlight %}


<h2 id="accessibility">Accessibility</h2>

### Use links and input buttons for clickable elements

Links and buttons are focusable and activatable by default in a browser, which means they are perceivable and operable to screen reader users and keyboard-only users. Rich JavaScript widgets (like video player controls) should be progressively enhanced on-top of elements that, by default, are already accessible.

<h2 id="seo">Search Engine Optimisation</h2>