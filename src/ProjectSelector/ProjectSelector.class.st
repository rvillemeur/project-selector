"
Project selector
Select which project you want to open.

ProjectSelector new open
"
Class {
	#name : #ProjectSelector,
	#superclass : #ComposablePresenter,
	#instVars : [
		'projects',
		'project1',
		'project2',
		'project3'
	],
	#category : #ProjectSelector
}

{ #category : #specs }
ProjectSelector class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :col | 
			col
				add: #project1;
				add: #project2;
				add: #project3 ]
			origin: 0 @ 0
			corner: 1 @ 0.7;
		yourself
]

{ #category : #'as yet unclassified' }
ProjectSelector >> fetchProject: aBaseline from: aRepository [
	Metacello new
		baseline: aBaseline;
		repository: aRepository;
		load
]

{ #category : #initialization }
ProjectSelector >> initializePresenter [

	self setActionsForProject1.
	self setActionsForProject2.
	self setActionsForProject3.	
]

{ #category : #initialization }
ProjectSelector >> initializeWidgets [
	"	projects := self newList.
	projects displayBlock: [ :m | m selector ]."

	project1 := self newCheckBox
		label: 'Pharo startup Settings';
		help: 'Automate pharo stuff on startup';
		yourself.
	project2 := self newCheckBox
		label: 'Argentum';
		help: 'financial and interest calculation made easy';
		yourself.
	project3 := self newCheckBox
		label: 'Glorp book';
		help: 'introduction to glorp';
		yourself.
	self focusOrder add: project1; add: project2; add: project3.
]

{ #category : #api }
ProjectSelector >> open [
	^ (self openDialogWithSpec
		okAction: [ self accept ];
		cancelAction: [ self cancel ])
		window modalRelativeTo: World;
		yourself
]

{ #category : #accessing }
ProjectSelector >> project1 [
	^ project1
]

{ #category : #accessing }
ProjectSelector >> project1: anObject [
	project1 := anObject
]

{ #category : #accessing }
ProjectSelector >> project2 [
	^ project2
]

{ #category : #accessing }
ProjectSelector >> project2: anObject [
	project2 := anObject
]

{ #category : #accessing }
ProjectSelector >> project3 [
	^ project3
]

{ #category : #accessing }
ProjectSelector >> project3: anObject [
	project3 := anObject
]

{ #category : #accessing }
ProjectSelector >> projects [
	^ projects
]

{ #category : #accessing }
ProjectSelector >> projects: anObject [
	projects := anObject
]

{ #category : #initialization }
ProjectSelector >> setActionsForProject1 [

	project1 whenActivatedDo: [ projects add: {'toto'} ].
	project1 whenDeactivatedDo: [ projects remove: {'toto'} ]

]

{ #category : #initialization }
ProjectSelector >> setActionsForProject2 [

	project2 whenActivatedDo: [ projects add: {'toto'} ].
	project2 whenDeactivatedDo: [ projects remove: {'toto'} ]

]

{ #category : #initialization }
ProjectSelector >> setActionsForProject3 [

	project3 whenActivatedDo: [ projects add: {'toto'} ].
	project3 whenDeactivatedDo: [ projects remove: {'toto'} ]

]

{ #category : #api }
ProjectSelector >> title [
	^ 'project selector'
]
