<?php
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// SOFTWARE NAME: eZ Xiti Interface
// SOFTWARE RELEASE: 1.7.0
// COPYRIGHT NOTICE: Copyright (C) 1999-2010 eZ Systems AS
// SOFTWARE LICENSE: GNU General Public License v2.0
// NOTICE: >
//   This program is free software; you can redistribute it and/or
//   modify it under the terms of version 2.0  of the GNU General
//   Public License as published by the Free Software Foundation.
//
//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.
//
//   You should have received a copy of version 2.0 of the GNU General
//   Public License along with this program; if not, write to the Free
//   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//   MA 02110-1301, USA.
//
//
// ## END COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
//
class xiti
{
	/**
	 * @var string
	 */
	private static $ini;
	/**
	 * 
	 * Enter description here ...
	 */
	function xiti()
	{
		xiti::$ini = eZINI::instance('xiti.ini');
	}
	function operatorList()
	{
		return array(
					'display_xiti_tag');
	}
	function namedParameterPerOperator()
	{
		return true;
	}
	function namedParameterList()
	{
		return array(
					'display_xiti_tag'=>array(
											'page_name'=>array(
															'type'=>'string',
															'required'=>false,
															'default'=>'')));
	}
	function modify($tpl,$operatorName,$operatorParameters,&$rootNamespace,&$currentNamespace,&$operatorValue,&$namedParameters)
	{
		$namedParameters = array_merge(array(
											'display_tags'=>true),$namedParameters);
		$page = $namedParameters['page_name'];
		$site_id = $this->getIni()->variable('SiteSettings','SiteId');
		$logo = $this->getIni()->variable('SiteSettings','Logo');
		$format = $this->getIni()->variable('SiteSettings','Format');
		$log_uri = $this->getIni()->variable('SiteSettings','LogUri');
		$publication_url = $this->getIni()->variable('SiteSettings','PublicationUrl');
		$formats = $this->getIni()->variable('Availables','Formats');
		$logos = $this->getIni()->variable('Availables','Logos');
		$noscript_page = $_SERVER['REQUEST_URI'];
		if(((class_exists('detectBots',true) && !detectBots::isBot()) || !class_exists('detectBots',true)) && in_array($logo,$logos) && in_array($format,$formats) && !empty($site_id) && !empty($logo) && !empty($format) && !empty($log_uri))
		{
			switch($operatorName)
			{
				case 'display_xiti_tag':
					$tpl = eZTemplate::factory();
					$tpl->setVariable('site_id',$site_id);
					$tpl->setVariable('log_uri',$log_uri);
					$tpl->setVariable('page',$page);
					$tpl->setVariable('logo',$logo);
					$tpl->setVariable('publication_url',$publication_url);
					$tpl->setVariable('noscript_page',$noscript_page);
					foreach($namedParameters as $namedParameterName=>$namedParameterValue)
						$tpl->setVariable($namedParameterName,$namedParameterValue);
					return ($operatorValue = $tpl->fetch('design:xiti-' . $format . '.tpl'));
					break;
			}
		}
	}
	/**
	 * Instanciate ini object
	 * @param string ini file name
	 * @return xiti
	 */
	public static function instance($_fileName = 'xiti.ini')
	{
		$self = new self();
		xiti::$ini = eZINI::instance($_fileName);
		return $self;
	}
	/**
	 * Return ezIni object
	 * @return eZINI
	 */
	public function getIni()
	{
		return xiti::$ini;
	}
}
?>
