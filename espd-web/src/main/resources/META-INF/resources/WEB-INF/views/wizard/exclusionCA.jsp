﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<%--
  ~
  ~ Copyright 2016 EUROPEAN COMMISSION
  ~
  ~ Licensed under the EUPL, Version 1.1 or – as soon they
  ~ will be approved by the European Commission - subsequent
  ~ versions of the EUPL (the "Licence");
  ~
  ~ You may not use this work except in compliance with the Licence.
  ~
  ~ You may obtain a copy of the Licence at:
  ~
  ~ https://joinup.ec.europa.eu/community/eupl/og_page/eupl
  ~
  ~ Unless required by applicable law or agreed to in
  ~ writing, software distributed under the Licence is
  ~ distributed on an "AS IS" basis,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
  ~ express or implied.
  ~ See the Licence for the specific language governing
  ~ permissions and limitations under the Licence.
  ~
  --%>

<c:if test="${!espd.extendCe}">
	<%request.setAttribute("exclusionCA", eu.europa.ec.grow.espd.xml.CriteriaTemplates.exclusionCA);%>
</c:if>
<c:if test="${espd.extendCe}">
	<%request.setAttribute("exclusionCA", eu.europa.ec.grow.espd.xml.CriteriaTemplates.exclusionCE);%>
</c:if>
<%request.setAttribute("nationalExclusionGrounds", eu.europa.ec.grow.espd.domain.enums.criteria.ExclusionCriterion.NATIONAL_EXCLUSION_GROUNDS);%>

<tiles:importAttribute name="flow"/>

<form:form id="espdform" role="form" class="form-horizontal" method="post" commandName="espd" data-toggle="validator">

    <tiles:insertDefinition name="viewChangeRole">
        <tiles:putAttribute name="agent" value="ca"/>
        <tiles:putAttribute name="page" value="${flow}/eo/exclusion"/>
        <tiles:putAttribute name="showLink" value="${flow == 'request'}"/>
    </tiles:insertDefinition>
    
    <div class="panel-default">
        <tiles:insertDefinition name="progress">
        	<tiles:putAttribute name="agent" value="${agent}"/>
        	<tiles:putAttribute name="flow" value="${flow}"/>
            <tiles:putAttribute name="exclusion" value="true"/>
        </tiles:insertDefinition>
        <div>
            <h2>
                <span data-i18n="createcaexcl_header"><s:message code="createcaexcl_header"/></span>
            </h2>
        </div>

		<tiles:insertDefinition name="topLevelCriteriaTemplate">
			<tiles:putAttribute name="topLevelCriteriaList" value="${exclusionCA}"/>
		</tiles:insertDefinition>

        <div class="panel panel-espd">
            <div class="panel-heading" data-toggle="collapse" data-target="#ca-national-section">
				<h4 class="panel-title">
					${span18n['crit_top_title_purely_national']}
				</h4>
            </div>
            <div id="ca-national-section" class="espd-panel-body panel-body collapse in">
                    <span data-i18n="crit_eu_main_purely_national" style="font-weight: bold;">
                        <s:message code='crit_eu_main_purely_national'/>
                    </span>

<c:if test="${!espd.extendCe}">
	<tiles:insertDefinition name="checkTemplate">
	                    <tiles:putAttribute name="field" value="purelyNationalGrounds"/>
	                    <tiles:putAttribute name="title_code" value="crit_eu_title_purely_national"/>
	                    <tiles:putAttribute name="description_code" value="crit_eu_text_purely_national"/>
	                    <tiles:putAttribute name="hasCriterion" value="true"/>
	                    <tiles:putAttribute name="criterion" value="${nationalExclusionGrounds}"/>
 			    <tiles:putAttribute name="ischecked" value="true"/>
			    <tiles:putAttribute name="is_always_checked" value="true"/> 
	                </tiles:insertDefinition>
</c:if>
<c:if test="${espd.extendCe}">
	<tiles:insertDefinition name="checkTemplate">
	                    <tiles:putAttribute name="field" value="purelyNationalGrounds"/>
	                    <tiles:putAttribute name="title_code" value="crit_eu_title_purely_national"/>
	                    <tiles:putAttribute name="description_code" value="crit_eu_text_purely_national"/>
	                    <tiles:putAttribute name="hasCriterion" value="true"/>
	                    <tiles:putAttribute name="criterion" value="${nationalExclusionGrounds}"/>
 			    <tiles:putAttribute name="ischecked" value="true"/>
			    <tiles:putAttribute name="is_always_checked" value="false"/> 
	                </tiles:insertDefinition>
</c:if>

	                
            </div>
        </div>
        <tiles:insertDefinition name="footerButtons">
            <tiles:putAttribute name="prev" value="procedure"/>
            <tiles:putAttribute name="next" value="selection"/>
        </tiles:insertDefinition>
    </div>
</form:form>
	
