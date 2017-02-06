<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notify_Manager_When_Employee_Deactivated</fullName>
        <description>Notify Manager When Employee Deactivated</description>
        <protected>false</protected>
        <recipients>
            <field>Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notify_Manager</template>
    </alerts>
    <fieldUpdates>
        <fullName>Assigned_To_Pune</fullName>
        <field>OwnerId</field>
        <lookupValue>Pune_Sales_Team</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Assigned To Pune</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assigned_to_Mumbai</fullName>
        <field>OwnerId</field>
        <lookupValue>Mumbai_Sales_Team</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Assigned to Mumbai</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Manager_Email</fullName>
        <field>Manager_Email__c</field>
        <formula>Manager__r.Manager_Email__c</formula>
        <name>Update Manager Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Record_type_to_Non_Technical</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Non_Technical</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Record type to Non Technical</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Assign To Mumbai Sales Team</fullName>
        <actions>
            <name>Assigned_to_Mumbai</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EMPLOYEE__c.City__c</field>
            <operation>equals</operation>
            <value>Mumbai</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Assign To Pune Sales Team</fullName>
        <actions>
            <name>Assigned_To_Pune</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EMPLOYEE__c.City__c</field>
            <operation>equals</operation>
            <value>Pune</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify the Manager of the Employee once the record is deactivated</fullName>
        <actions>
            <name>Notify_Manager_When_Employee_Deactivated</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>workflow to notify the Manager of the Employee once the record is deactivated. (Use: Text Email templates for email notification)</description>
        <formula>!ISNEW() &amp;&amp;  ISCHANGED(Is_Active__c) &amp;&amp; Is_Active__c == false</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Employee Email</fullName>
        <actions>
            <name>Update_Manager_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Manager__r.Employee_Email__c  !=  Manager_Email__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Workflow when Current Employee get false</fullName>
        <actions>
            <name>Update_Record_type_to_Non_Technical</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>EMPLOYEE__c.Current_Employee__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>EMPLOYEE__c.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Non-Technical</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
