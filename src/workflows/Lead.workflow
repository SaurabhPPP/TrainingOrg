<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Follow_Up_Required_On_Lead</fullName>
        <ccEmails>parthv4u@gmail.com</ccEmails>
        <description>Follow Up Required On Lead</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Lead_Follow_Up</template>
    </alerts>
    <rules>
        <fullName>Lead Follow Up</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>notEqual</operation>
            <value>Closed - Converted,Closed - Not Converted</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Follow_Up__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Follow_Up_Required_On_Lead</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Lead.Follow_Up__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
