{set-block scope=root variable=cache_ttl}0{/set-block}
{* Template HTML d'affichage du taggage Xiti *}
{if and(is_set($display_tags),eq($display_tags,true()))}
	<a href="{if eq($publication_url,'')}http://www.xiti.com/xiti.asp?s={$site_id}{else}{$publication_url}{/if}" title="WebAnalytics" target="_blank">
		<script src="/mdxiti/script.js" type="text/javascript" charset="utf-8"></script>
		<noscript>
		Mesure d'audience ROI statistique webanalytics par <img width="39" height="25" src="http://{$log_uri}.xiti.com/hit.xiti?s={$site_id}&p={$noscript_page}" alt="WebAnalytics" />
		</noscript>
	</a>
{else}
	Xt_param = 's={$site_id}&p='+{if ne($page,'')}'{$page}'{else}location.pathname{/if};
	{literal}
	try {Xt_r = top.document.referrer;}
	catch(e) {Xt_r = document.referrer; }
	Xt_h = new Date();
	{if eq($logo,'hit')}
	Xt_i = '<img width="39" height="25" border="0" alt="" ';
	{else}
	Xt_i = '<img width="80" height="15" border="0" alt="" ';
	{/if}
	{literal}
	Xt_i += 'src="http://{$log_uri}.xiti.com/hit.xiti?'+Xt_param;
	Xt_i += '&hl='+Xt_h.getHours()+'x'+Xt_h.getMinutes()+'x'+Xt_h.getSeconds();
	if(parseFloat(navigator.appVersion)>=4)
	{Xt_s=screen;Xt_i+='&r='+Xt_s.width+'x'+Xt_s.height+'x'+Xt_s.pixelDepth+'x'+Xt_s.colorDepth;}
	document.write(Xt_i+'&ref='+Xt_r.replace(/[<>"]/g, '').replace(/&/g, '$')+'" title="Internet Audience">');
{/if}