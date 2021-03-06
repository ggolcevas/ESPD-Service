/*
 *
 * Copyright 2016 EUROPEAN COMMISSION
 *
 * Licensed under the EUPL, Version 1.1 or – as soon they
 * will be approved by the European Commission - subsequent
 * versions of the EUPL (the "Licence");
 *
 * You may not use this work except in compliance with the Licence.
 *
 * You may obtain a copy of the Licence at:
 *
 * https://joinup.ec.europa.eu/community/eupl/og_page/eupl
 *
 * Unless required by applicable law or agreed to in
 * writing, software distributed under the Licence is
 * distributed on an "AS IS" basis,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied.
 * See the Licence for the specific language governing
 * permissions and limitations under the Licence.
 *
 */

package eu.europa.ec.grow.espd.xml.request.selection
import eu.europa.ec.grow.espd.domain.enums.criteria.SelectionCriterion
import eu.europa.ec.grow.espd.domain.EspdDocument
import eu.europa.ec.grow.espd.domain.QualityAssuranceCriterion
import eu.europa.ec.grow.espd.xml.base.AbstractSelectionCriteriaFixture
/**
 * Created by ratoico on 12/9/15 at 1:48 PM.
 */
class CertificatesIndependentBodiesQARequestTest extends AbstractSelectionCriteriaFixture {

    def "32. should contain the 'Certificates by independent bodies about quality assurance standards' criterion"() {
        given:
        def espd = new EspdDocument(certificateIndependentBodiesAboutQa: new QualityAssuranceCriterion(exists: true))

        when:
        def request = generateRequestXml(espd)
        def idx = getRequestCriterionIndex(SelectionCriterion.CERTIFICATE_INDEPENDENT_BODIES_ABOUT_QA)

        then: "CriterionID element"
        checkCriterionId(request, idx, "d726bac9-e153-4e75-bfca-c5385587766d")

        then: "CriterionTypeCode element"
        checkCriterionTypeCode(request, idx, "CRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.CERTIFICATES.QUALITY_ASSURANCE.QA_INDEPENDENT_CERTIFICATE")

        then: "CriterionName element"
        request.Criterion[idx].Name.text() == "Certificates by independent bodies about quality assurance standards"

        then: "CriterionDescription element"
        request.Criterion[idx].Description.text() == "Will the economic operator be able to produce certificates drawn up by independent bodies attesting that the economic operator complies with the required quality assurance standards, including accessibility for disabled persons?"

        then: "CriterionLegislationReference element"
        checkLegislationReference(request, idx, "62(2)")

        then: "check all the sub groups"
        request.Criterion[idx].RequirementGroup.size() == 2

        then: "G1"
        def g1 = request.Criterion[idx].RequirementGroup[0]
        g1.ID.text() == "0e88f63c-5642-4a17-833b-ae5800e1750a"
        g1.@pi.text() == ""
        g1.RequirementGroup.size() == 1
        g1.Requirement.size() == 1
        checkRequirement(g1.Requirement[0], "15335c12-ad77-4728-b5ad-3c06a60d65a4", "Your answer?", "INDICATOR")

        then: "G1.1"
        def g1_1 = g1.RequirementGroup[0]
        g1_1.ID.text() == "76c7cf31-be3a-4a7e-8c35-a65ae60cd674"
        g1_1.@pi.text() == "GROUP_FULFILLED.ON_FALSE"
        g1_1.RequirementGroup.size() == 0
        g1_1.Requirement.size() == 1
        checkRequirement(g1_1.Requirement[0], "8c5d1e13-54f7-4895-a65c-b8e09253130c",
                "If not, please explain why and specify which other means of proof concerning the quality assurance scheme can be provided:", "DESCRIPTION")

        then: "info available electronically sub group"
        def g2 = request.Criterion[idx].RequirementGroup[1]
        checkInfoAvailableElectronicallyRequirementGroup(g2)
    }

}