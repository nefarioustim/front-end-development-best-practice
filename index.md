---
title:      "Front End Development Best Practice"
layout:     index
---

Front End Development Best Practice
===================================

Over the past ten years the discipline of Front End Development has emerged
from the implementation of web standards by web developers. However, web
standards are really only the beginnings of a well developed website. The
standards we adopt _beyond_ web standards also inform the quality of our
development, and as a result it is often useful to develop best practices for
the future. This document is intended as the starting point for your own best
practices.

An exceptional website is:

* [Available to all](#available-to-all)
    * [Client agnostic](#client-agnostic)
    * [Standardised](#leverage-web-standards)
    * [Accessible](#accessibility)
    * Crawlable
    * Bookmarkable
* Respectful
    * Passive
    * Predictable
    * Fast
    * Secure
* Crafted
    * Maintainable
    * Scalable

<h2 id="available-to-all">Make content available to all</h2>

A high quality website should be available to as many users as possible,
regardless of their client, technology, abilities, and situation. The web is
entirely designed for sharing content; there's really no reason to break that
paradigm.

<h3 id="client-agnostic">Be client agnostic</h3>

The users' choice of browsing client should be mostly irrelevant to your
decisions as a web developer. Obviously there are occasional exceptions to
this rule, usually where user input and control is different. Examples of
exceptions are building in accessibility or developing mobile, touch, and
printer stylesheets. Even with these exceptions, however, we should always
attempt to support the largest range of devices with the minimum adjustment.

#### A browser support standard will help

It's important to understand the technologies being used to browse your
content and test accordingly. This information is best gleaned from your web
analytics and log files. Once you have analysed and assimilated that
information, you'll likely want to follow a **graded browser support**
strategy to allow you to focus your development and testing efforts on the
browsers that matter the most to you whilst not being held back by legacy
browsers being used by a small-but-significant proportion of your visitors. In
lieu of having your own browser stats, here's what we'd recommend based on
global browser market share:

Primarily, test and ensure that the visitor gets a first-class browsing and
interaction experience in the following browsers:

* Internet Explorer 7+ (on Windows)
* Mozilla Firefox 3.6+ (on OSX and Windows)
* Chrome 5+ (on OSX and Windows)
* Safari 5+ (on OSX)
* Opera 10+ (on Windows)

This doesn't mean the pages have to be pixel-perfect between browsers, but as
close as reasonably possible to the design requirement with all of the
functionality and interactivity working perfectly.

Secondly, test and ensure that the visitor gets a useable and
not-obviously-broken experience with:

* Internet Explorer 6
* Safari 4

Once you have a better understanding of the users of your site, you may opt to
drop support for any of these combinations, or even add some additional
browsers.

Other browser support matrices are available:

* [YUI Graded Browser Support](http://developer.yahoo.com/yui/articles/gbs/)
* [BBC Browser Support Standards](http://www.bbc.co.uk/guidelines/futuremedia/technical/browser_support.shtml#support_table),
* [jQuery Browser Compatibility](http://docs.jquery.com/Browser_compatibility).

#### Support browsers effectively and avoid pixel perfection

Requiring the same experience for all users creates a barrier to
participation. Availability and accessibility of content should be our key
priority. With this as an ideal, there is absolutely no reason to seek pixel
perfection cross-browser. A good front end developer should take
responsibility to communicate this and educate where appropriate.

See also:

* [Effective browser support](http://boagworld.com/technology/effective-browser-support/)
* [Cross-browser support: Be gone with pixel perfection](http://www.gottaquirk.com/2011/03/11/cross-browser-support-be-gone-with-pixel-perfection/)

#### Improve graceful CSS degradation with unobtrusive hacks

Sometimes there is a need to overcome significant rendering issues with
certain browser engines. To do this you should not be afraid of using an
unobtrusive hack such as the IE underscore and star hacks:

Where Internet Explorer 6 and 7 need extra style rules to create a non-broken
browsing experience, use the underscore and/or star hacks to create
IE-specific style rules. Use CSS comments to document the use of CSS hacks.

{% highlight css %}
.module {
	float: left;
	_display: inline; /* Double margin fix for IE6 */
}
{% endhighlight %}

The benefit of managing the adjustment this way is that you can seat it next
to the original property adjustment and comment accordingly. This allows a
clearer understanding when you come back to this rule later during
maintenance.

This rule only applies where the CSS hack is unobtrusive enough to not require
an entirely new selector, i.e. it only affects a single property declaration
as above.

See also:

* [CSS hacks for IE only style rules](http://webstandardstips.com/2008/11/18/css-hacks-for-ie-only-style-rules/)
* [Targeting IE 5.x, 6 and 7 Separately](http://www.ejeliot.com/blog/63)
* [CSS Hacks: The underscore hack](http://www.css-zibaldone.com/articles/hacks/csshacks.html#underscore-hack)

#### Target IE specifically with conditional comments

If we're entirely honest with ourselves as web developers, we can probably
admit that the majority of woes we experience in CSS are as a direct result of
features that any given version of Internet Explorer has not implemented.

The best technique for targetting IE is to adopt conditional comments to add
IE specific classes to the `body` element of the page in HTML:

{% highlight html %}
<!--[if lt IE 7 ]>
<body class="ie ie6">
<![endif]--> 
<!--[if IE 7 ]>
<body class="ie ie7">
<![endif]--> 
<!--[if IE 8 ]>
<body class="ie ie8">
<![endif]--> 
<!--[if IE 9 ]>
<body class="ie ie9">
<![endif]--> 
<!--[if gt IE 9]>
<body class="ie">
<![endif]-->
<!--[if !IE]><!-->
<body>
<!--<![endif]-->
{% endhighlight %}

We're using the `body` element here because attaching the `ie` classes to the
`html` element would result in IE not forcing standards mode and potentially
trigger various 'quirks' rendering modes.

With the classes in place we can then write CSS rules like so:

{% highlight css %}
#navigation {
    float: left;
    margin-right: 30px;
    background: #ccc;
    background: #ccc -webkit-gradient(linear, left top, left bottom, from(#999), to(#ccc)) no-repeat;
    background: #ccc -moz-linear-gradient(top,  #999,  #ccc) no-repeat;
}
/*
    IE specific rule to fix double margin bug, remove potentially 
    render-slowing filters and trigger hasLayout.
*/
.ie #navigation {
    display: inline;
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#ff999999, endColorstr=#ffcccccc);
    -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#ff999999, endColorstr=#ffcccccc)";
    zoom: 1;
}
{% endhighlight %}

This stops us having to maintain a separate stylesheet specifically for IE and
keeps related CSS rules together. This improves readability and ensures that
all browser fixes are next to each other when you return at a later date.

See also:

* \#TODO

#### Favour feature sniffing over browser sniffing in JavaScript

Browser "sniffing" is the act of attempting to discern a user's browser by
some means. This information can then be used in conditional code to control
output or interaction for a specific browser. This technique used to be used a
great deal in JavaScript, when browsers had very different rendering engines
and didn't all conform to web standards.

Browser sniffing is not a good solution. If you adopt it, you will usually end
up maintaining separate streams of development whenever you need to add or
update features. It's also of note that some browsers identify themselves
incorrectly to get _around_ legacy browser sniffing code. In short, this
technique does not scale.

A more scalable approach is to use object detection in JavaScript to discover
if a feature is available before you use it. An example of this might be:

{% highlight javascript %}
// Test if querySelector exists on the document object
if (document.querySelector) {
    // Make use of it
    element = document.querySelector(selectors);
}
{% endhighlight %}

The obvious advantage here is that it is browser agnostic; there are no
assumptions as to which browser is involved at all. Using this technique, we
overcome the scalability and maintenance headaches incurred through browser
sniffing, and we can develop for graceful degradation from the outset.

See also:

* \#TODO

<h3 id="leverage-web-standards">Leverage web standards</h3>

Implementing web standards is the foundation for maintainability,
accessibility (both for machines _and_ people), stability, and scalability.
Web standards are defined by the people who use them; browser makers, web
developers, content providers, and other organisations.

Creating web pages in accordance with the standards shortens site development
time and makes pages easier to maintain. Debugging and troubleshooting become
easier, because the code follows a standard.

#### Use HTML not XHTML

Always use HTML served as `text/html` instead of XHTML. There are many reasons
to avoid serving XHTML as XML:

  * XML has draconian error-handling. Some browsers (like Firefox) implement
    this by rendering a [Yellow Screen of
    Death](http://kb.mozillazine.org/XML_parsing_error) instead of a document.
    Other browsers (like Opera) swap to rendering the document as if it were
    text/html. Websites commonly mix up code from lots of different sources
    (developers, non-technical authors, third-party content like feeds,
    third-party code like libraries and ads). Sanitising and sandboxing these
    markup sources is very hard to do perfectly and the costs of failure can
    be significant (e.g. loss of ad revenue on an entertainment site,
    forfeiting a sale on an ecommerce site, blocking access to information in
    an emergency on a government site).
    
  * Some features widely used in text/html, such as `document.write`, error in
    XML. Even if you avoid these features in your code, third-party code you
    wish to integrate (libraries, widgets, ads, feed content, etc.) may not.
    
  * XHTML has generally poorer compatibility than HTML, as it’s never been a
    priority for browser developers. By default, IE < 9 shows a download
    dialog instead of rendering a webpage when XHTML is served with its
    official XHTML media type (application/xhtml+xml).

Some authors opt to write markup that will function when served as XML or
text/html. Given the subtle differences between the handling of XML and
text/html, this is a great way to double the testing you need to do for no
significant benefit.

Whilst the well-formed nature of XHTML is certainly attractive to the markup
purist, you could use a linter to enforce your chosen style of (potentially
XMLish) HTML.

See also:

   * David Hammond: [Beware of XHTML](http://www.webdevout.net/articles/beware-of-xhtml)
   * [WHATWG: HTML vs. XHTML](http://wiki.whatwg.org/wiki/HTML_vs._XHTML)
   * [W3C: XHTML Media Types - Second Edition](http://www.w3.org/TR/xhtml-media-types/)
   * [HTML Lint](http://lint.brihten.com/html/)

#### Use the HTML Living Standard `DOCTYPE`

In the brave new world of [HTML as a living standard](http://whatwg.org/html),
the ideal `DOCTYPE` to use is as follows:

{% highlight html %}
<!DOCTYPE html>
{% endhighlight %}

The first character of the `DOCTYPE` string should be the very first character
in your document (even whitespace counts).  Other `DOCTYPE` strings may cause
browsers to render your document using various ‘quirk’ modes intended for
supporting legacy documents.

   * Henri Sivonen: [Activating Browser Modes with Doctype](http://hsivonen.iki.fi/doctype/)

#### Always specify a language and text direction

For improved internationalisation support, always specify a language and
direction in the root element of your document. This is used by all user
agents, screen readers, and search engine spiders to better understand how to
voice your content:

{% highlight html %}
<html lang="en-gb" dir="ltr">
{% endhighlight %}

See also:

* \#TODO

#### Always specify a character-set within your document

It is important to make sure you specify a character-set within your document
in case so that you can be sure your content is displayed properly by user
agents. The correct position for this is before any other content or meta content within your page. For this reason, it's best to place it as close to
the opening `head` tag as possible:

{% highlight html %}
<!DOCTYPE html>
<html lang="en-gb" dir="ltr">
    <head>
        <meta charset="utf-8">
        <title>Time machines of the Renaissance</title>
        …
{% endhighlight %}

See also:

* \#TODO

#### Use structured semantic markup

#### Semantic markup includes semantic element identifiers

<h3 id="accessibility">Build in accessibility from the start</h3>

Accessibility is not a "feature", it is a requirement. Ostracising or
punishing a user simply because of the technology they use to browse your
content is unacceptable, and even illegal in some countries. Further to this,
developing accessible websites is not _difficult_ but does require a little
extra thought and diligence at times.

#### Use links and input buttons for clickable elements

Links and buttons are focusable and activatable by default in a browser, which
means they are perceivable and operable to screen reader users and
keyboard-only users. Rich JavaScript widgets (like video player controls)
should be progressively enhanced on-top of elements that, by default, are
already accessible.

<h2 id="presentation">Presentation</h2>

### Use CSS3 presentation effects over old presentation hacks

The following effects can be done in CSS3, with no fallback when not supported
in browsers (like Internet Explorer 6 & 7):

* Rounded corners with `border-radius`

* Gradient backgrounds with `background: gradient` and `background:
  linear-gradient`. Where possible, and when it causes no adverse effects use
  Microsoft's group of filters to add gradients for Internet Explorer. Also
  supply an appropriate default fallback background colour.

* Box shadows with `box-shadow`

Don't forget to add vendor-specific style properties where necessary.

### Use overflow to self-clear contained floats

Where possible use `overflow` on the containing element to clear floated
elements.

{% highlight css %}
.module {
	overflow: hidden;
}
{% endhighlight %}

Where content inside of this container needs to spill out of the containing
div (for example a dropdown menu near the bottom of the container), then use
the content after method of clearing (using `zoom: 1` for Internet Explorer):

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

In jQuery lookups for elements with a specific class where possible use an
element name as part of the selector. So instead of :

{% highlight javascript %}
var $todoItems = $('.todo');
{% endhighlight %}

Specify an element name in the selector:

{% highlight javascript %}
var $todoItems = $('li.todo');
{% endhighlight %}

Under the bonnet browsers that don't have a native
`document.getElementsByClassName()` method, will use a
`document.getElementsByTagName()` method with the element name instead of a
`*`. This will return a smaller Node list and thus be quicker.

### Use references instead of repetitive DOM lookups

If you are doing some non-trivial work with a particular jQuery wrapped set,
store the wrapped set as a reference so that you can avoid recalculating the
same wrapped set over and over. This approach also allows breaking down the
code into easier to digest and understandable chunks.

Also to make it more obvious that we have a reference to a jQuery wrapped set
prefix the reference variable with a `$`.

{% highlight javascript %}
var $items = $('ul.checklist li');

if ($items.length) {
	$('span.total').text($items.length);
	$items.filter('.done').remove();
}
{% endhighlight %}

### Break chained methods over multiple lines for readability

Although chaining is a useful feature of jQuery, it's too easy to create
unreadable code. So be generous on the use of spacing and linebreaks and aim
to make the code as readable as possible.

{% highlight javascript %}
	$('form.signup')
		.bind('submit', formSubmitHandler)
		.bind('validate.form', validateFormHandler)
		.bind('save.form', saveFormHandler)
		.removeClass('disableSubmit');
{% endhighlight %}

Using jQuery's `end()` to unwind the chaining stack is a sure sign that your
chaining statement is in danger of becoming difficult to understand. When your
chaining gets this complex, it's best to get a reference to the common
ancestor and logically separate your complex chain into several less-complex
chains.

<h2 id="usability">Usability</h2>

### Always put a useful URL in `href`

Browsers allow users to do various things to hyperlinks. Most obviously, you
can open the link in the current browsing context (tab or window). But other
secondary functions are often provided, including opening the link in another
browsing context, bookmarking the link, and copying the link elsewhere. Browser
addons add yet more functionality, such as opening the link in a different
browser or sharing it via social bookmarking sites. Sometimes these secondary
functions are attached to pressing a key and mouse button in combination,
sometimes they are listed in the context menu.

The common practice of using `a href="#"` as a hook for some JS to transition
to a new state (e.g. open a dialog for adding an item) breaks all these
secondary functions, since the link in the `href` does not represent the
expected state (instead it points to the top of the current document).

Instead, use a URL that can serve up a representation of the expected state
(e.g. http://example.com/add), or use a button if there’s no such URL.

<h2 id="performance">Performance</h2>

### Profile first, optimise second

Performance is just one aspect that a developer has to concern themselves with
when creating a modern website or web application, albeit one that has a
definite impact on user satisfaction. Blindly following every piece of
optimisation advice you find on the Internet would be time consuming, lead to
harder-to-understand code and would predominantly be a colossal waste of time.

Profile your code as you're writing it, and profile the entire project at
regular intervals, to identify the hot spots that are causing you the most
pain. Once you've done that, you can then apply just the performance
optimisations that will help you overcome those issues. Remember to test these
as you're going though — advice on the Internet has an unnerving habit of
being misleading, and the techniques on offer may not exactly apply to your
situation.