---
---

$ = (selector) ->
	document.querySelectorAll(selector)
_ = (nodeList, fn) ->
	if fn
		Array.prototype.map.call(nodeList, fn)
	else
		Array.prototype.slice.call(nodeList)
Element.prototype.prependChild = (child) ->
	this.insertBefore child, this.firstChild



navbar = $('.site-header')[0]

navigate = (e) ->

	if e.target.href
		e.preventDefault()
		fixbarOffset = navbar.getBoundingClientRect().height
		target = e.target.attributes.href.nodeValue.toString()
		return if not target
		sectionTarget = $(target)[0] or $('a[name=' + target.substr(1) + ']')[0]
		if sectionTarget
			scrollTarget = sectionTarget.offsetTop - fixbarOffset
			scrollToY scrollTarget, 500, 'easeInOutQuint', () -> 
				false


_( $('a[href^="#"]') ).forEach (link) ->
	link.addEventListener 'click', navigate



supportPageOffset = not (window.pageXOffset is undefined)
isCSS1Compat = ((document.compatMode or "") is "CSS1Compat")
# x = if supportPageOffset then window.pageXOffset else if isCSS1Compat then document.documentElement.scrollLeft else document.body.scrollLeft
logo = navbar.querySelector '.site-title img'
logo.classList.add 'initial'

scrollSpy = () ->
	links = _( $('.site-nav .trigger .page-link') )
	selectedHash = '#topo'

	links.forEach (link) ->
		thisSection = $(link.hash)[0]
		bounds = thisSection.getBoundingClientRect()
		if bounds.top <= window.innerHeight * .3 and bounds.bottom > 0
			selectedHash = link.hash

	links.forEach (link) ->
		if link.hash is selectedHash
			link.classList.add 'active'
		else
			link.classList.remove 'active'

onScroll = (e) ->
	y = if supportPageOffset then window.pageYOffset else if isCSS1Compat then document.documentElement.scrollTop else document.body.scrollTop
	if y
		logo.classList.remove 'initial'
	else
		logo.classList.add 'initial'
	scrollSpy()


window.addEventListener 'scroll', onScroll
