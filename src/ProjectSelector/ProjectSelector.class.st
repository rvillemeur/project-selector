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
		'project3',
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

{ #category : #api }
ProjectSelector >> height [
	^ 200
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

{ #category : #accessing }
ProjectSelector >> projectList [
	^ projectList
]

{ #category : #accessing }
ProjectSelector >> projectList: anObject [
	projectList := anObject
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

{ #category : #api }
ProjectSelector >> width [
	^ 300
]
