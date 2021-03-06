component singleton
{
	// public methods (aka sgml-tags)
	public string function a(string content, struct attrs=structnew(), struct dataAttrs=structnew())
	{
		return tag("a", content, attrs, dataAttrs);
	}


	public string function br()
	{
		return starttag("br");
	}


	public string function div(string content, struct attrs=structnew(), struct dataAttrs=structnew())
	{
		return tag("div", content, attrs, dataAttrs);
	}


	public string function img(struct attrs=structnew(), struct dataAttrs=structnew())
	{
		return startendtag("img", attrs, dataAttrs);
	}


	public string function p(string content, struct attrs=structnew(), struct dataAttrs=structnew())
	{
		return tag("p", content, attrs, dataAttrs);
	}


	public string function span(string content, struct attrs=structnew(), struct dataAttrs=structnew())
	{
		return tag("span", content, attrs, dataAttrs);
	}


	public string function table(string content, struct attrs=structnew(), struct dataAttrs=structnew())
	{
		return tag("table", content, attrs, dataAttrs);
	}


	public string function td(string content, struct attrs=structnew(), struct dataAttrs=structnew())
	{
		return tag("td", content, attrs, dataAttrs);
	}


	public string function tr(string content, struct attrs=structnew(), struct dataAttrs=structnew())
	{
		return tag("tr", content, attrs, dataAttrs);
	}


	public string function starttag(string name)
	{
		return "<" & name & ">";
	}


	public string function endtag(string name)
	{
		return "</" & name & ">";
	}


	// private methods
	private string function startendtag(string name, struct attrs, struct dataAttrs)
	{
		if ( StructCount(attrs) eq 0 and StructCount(dataAttrs) eq 0 )
			return "<" & name & " />";
		else
			return "<" & name & serializeAttributes(attrs) & serializeAttributes(dataAttrs, "data") & " />";
	}


	private string function serializeAttributes(struct attrs, string prefix="")
	{
		var sa = "";
		if ( len(prefix) gt 0 )
			prefix = prefix & "-";
		for(key in arguments.attrs)
			sa = sa & " " & prefix & lcase(key) & "=" & chr(34) & arguments.attrs[key] & chr(34);
		return sa;
	}


	private string function tag(string name, string content, struct attrs, struct dataAttrs)
	{
		if ( StructCount(attrs) eq 0 and StructCount(dataAttrs) eq 0 )
			return starttag(name) & content & endtag(name);
		else
			return "<" & name & serializeAttributes(attrs) & serializeAttributes(dataAttrs, "data") & ">" & content & endtag(name);
	}
}
