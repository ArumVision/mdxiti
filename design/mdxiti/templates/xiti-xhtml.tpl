{set-block scope=root variable=cache_ttl}0{/set-block}
{* Template XHTML d'affichage du taggage Xiti *}
{if and(is_set($display_tags),eq($display_tags,true()))}
<div id="xiti-logo">
	<script src="/mdxiti/script.js" type="text/javascript" charset="utf-8"></script>
	<noscript>
		<div id="xiti-logo-noscript">
			<a href="{if eq($publication_url,'')}http://www.xiti.com/xiti.asp?s={$site_id}{else}{$publication_url}{/if}" title="WebAnalytics" >WebAnalytics solution by <img width="80" height="15" src="http://{$log_uri}.xiti.com/g.xiti?s={$site_id}&amp;p={$noscript_page}&amp;" alt="WebAnalytics - AT Internet" style="border-width:0"/></a>
		</div>
	</noscript>
</div>
{else}
	var xt_link=document.createElement('a');
	xt_link.href='{if eq($publication_url,'')}http://www.xiti.com/xiti.asp?s={$site_id}{else}{$publication_url}{/if}';
	xt_link.title='WebAnalytics';
	xt_link.className='xiti-link';
	xt_link.setAttribute('class','xiti-link');
	{literal}
	xt_link.onclick=function(){window.open(this.href);return false};
	xt_link.setAttribute('onclick','window.open(this.href);return false');
	{/literal}
	Xt_param='s={$site_id}&p='+{if ne($page,'')}'{$page}'{else}location.pathname{/if};
	{literal}
	try{Xt_r=top.document.referrer;}
	catch(e){Xt_r=document.referrer;}
	{/literal}
	Xt_h=new Date();
	var xt_img=document.createElement('img');
	{if eq($logo,'hit')}
	xt_img.width=39;
	xt_img.height=25;
	{else}
	xt_img.width=80;
	xt_img.height=15;
	{/if}
	xt_img.border=0;
	Xt_param+='&hl='+Xt_h.getHours()+'x'+Xt_h.getMinutes()+'x'+Xt_h.getSeconds();
	{literal}
	if(parseFloat(navigator.appVersion)>=4)
	{
		Xt_s=screen;
		Xt_param+='&r='+Xt_s.width+'x'+Xt_s.height+'x'+Xt_s.pixelDepth+'x'+Xt_s.colorDepth;
	}
	{/literal}
	Xt_param+='&ref='+Xt_r.replace(/[<>"]/g, '').replace(/&/g, '$');
	xt_img.src='http://{$log_uri}.xiti.com/{$logo}.xiti?'+Xt_param;
	xt_link.appendChild(xt_img);
	document.getElementById('xiti-logo')?document.getElementById('xiti-logo').appendChild(xt_link):null;
{/if}