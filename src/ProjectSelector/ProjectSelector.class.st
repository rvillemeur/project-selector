"
Project selector
Select which project you want to open.

ProjectSelector new open

Testing the UI can be done with the following script: 
| pb |
pb := ProjectSelector new.
pb buildWithSpec .
(pb projectList listItems at:2) toggleState.
self assert: ((pb projectSelected  indexOf: #project2) = 1 ).

"
Class {
	#name : #ProjectSelector,
	#superclass : #ComposablePresenter,
	#instVars : [
		'project1',
		'project2',
		'project3',
		'projectSelected',
		'projectList'
	],
	#category : #ProjectSelector
}

{ #category : #specs }
ProjectSelector class >> defaultSpec [
	^ SpecLayout composed
		add: #projectList;
		yourself
]

{ #category : #api }
ProjectSelector >> accept [
self projectSelected do: [ :project | self getProject: (self projectCollection at: project) asDictionary ].
^ self window close
]

{ #category : #api }
ProjectSelector >> cancel [
	^ self window close
]

{ #category : #api }
ProjectSelector >> extent [
	^ self width @ self height
]

{ #category : #'as yet unclassified' }
ProjectSelector >> fetchProject: aBaseline from: aRepository [
	Metacello new
		baseline: aBaseline;
		repository: aRepository;
		load
]

{ #category : #'as yet unclassified' }
ProjectSelector >> getProject: aCollection [ 
	self fetchProject: (aCollection at: #baseline) from: (aCollection at: #repository)
]

{ #category : #api }
ProjectSelector >> height [
	^ 200
]

{ #category : #initialization }
ProjectSelector >> initialize [
	super initialize.
	projectSelected  := OrderedCollection new.
	^ self
]

{ #category : #initialization }
ProjectSelector >> initializePresenter [

	self setActionsForProject1.
	self setActionsForProject2.
	self setActionsForProject3.	
]

{ #category : #initialization }
ProjectSelector >> initializeWidgets [
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
	projectList := (self instantiate: ListPresenter)
		displayBlock: [ :x | x buildWithSpec ];
		items: {project1 . project2 . project3};
		yourself.
	self focusOrder
		add: project1;
		add: project2;
		add: project3
]

{ #category : #api }
ProjectSelector >> open [
	^ (self openDialogWithSpec
		okAction: [ self accept ];
		cancelAction: [ self cancel ])
		window centered; modalRelativeTo: World; isResizeable: false
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

{ #category : #initialization }
ProjectSelector >> projectCollection [
	^ {(#project1
		->
			{(#name -> 'Pharo startup Settings').
			(#baseline -> 'PharoStartupSettings').
			(#repository
				-> 'github://rvillemeur/PharoStartupSettings/repository')}).
	(#project2
		->
			{(#name -> 'Argentum').
			(#baseline -> 'Argentum').
			(#repository -> 'github://rvillemeur/argentum/repository')}).
	(#project3
		->
			{(#name -> 'Glorp book').
			(#baseline -> 'GlorpBook').
			(#repository -> 'github://rvillemeur/glorpbook/repository')})}
		asDictionary
]

{ #category : #accessing }
ProjectSelector >> projectList [
	^ projectList
]

{ #category : #accessing }
ProjectSelector >> projectList: anObject [
	projectList := anObject
]

{ #category : #accessing }
ProjectSelector >> projectSelected [
	^ projectSelected
]

{ #category : #accessing }
ProjectSelector >> projectSelected: anObject [
	projectSelected := anObject
]

{ #category : #initialization }
ProjectSelector >> selectProject: aProject [
 projectSelected add: aProject.


]

{ #category : #initialization }
ProjectSelector >> setActionsForProject1 [

	project1 whenActivatedDo: [ self selectProject: #project1 ].
	project1 whenDeactivatedDo: [ self unselectProject:  #project1 ]

]

{ #category : #initialization }
ProjectSelector >> setActionsForProject2 [

	project2 whenActivatedDo: [ self selectProject:  #project2 ].
	project2 whenDeactivatedDo: [ self unselectProject:  #project2 ]

]

{ #category : #initialization }
ProjectSelector >> setActionsForProject3 [

	project3 whenActivatedDo: [ self selectProject: #project3 ].
	project3 whenDeactivatedDo: [ self unselectProject:  #project3 ]

]

{ #category : #api }
ProjectSelector >> title [
	^ 'project selector'
]

{ #category : #initialization }
ProjectSelector >> unselectProject: aProject [
	projectSelected remove: aProject
]

{ #category : #api }
ProjectSelector >> width [
	^ 300
]
