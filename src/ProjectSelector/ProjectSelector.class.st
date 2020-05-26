"
Project selector
Select which project you want to open.

ProjectSelector open

Testing the UI can be done with the following script: 
| pb |
pb := ProjectSelector new.
pb buildWithSpec .
(pb projectList listItems at:2) toggleState.
self assert: ((pb projectSelected  indexOf: #project2) = 1 ).

Note, if we want to use the power of dynamic declaration of variable, here are the steps:
- In initializeWidget, we register dynamic components with 'self assign: model to: key'
In our case, key looks like #project1 for example
We can then iterate on our dynamic variable like this:
|projects|
projects := OrderedCollection new.
(1 to: 3 do: [ :count | projects add: (self perform: (('project' , count asString) asSymbol)) ]) 
projects then get the list of 3 projects declared dynamically .

"
Class {
	#name : #ProjectSelector,
	#superclass : #SpPresenter,
	#instVars : [
		'projectSelected',
		'projectList',
		'projects',
		'okButton',
		'cancelButton'
	],
	#category : #ProjectSelector
}

{ #category : #specs }
ProjectSelector class >> defaultSpec [
	^ SpBoxLayout newVertical 
		add: #projectList withConstraints: [ :constraints | constraints padding: 5; expand: true; fill: true];
		yourself
]

{ #category : #specs }
ProjectSelector class >> open [
<example>
	^ self new openModalWithSpec
]

{ #category : #initialization }
ProjectSelector class >> projectCollection [
	^ {(#project1
		->
			{(#name -> 'Pharo startup Settings').
			(#help -> 'Automate pharo stuff on startup').
			(#baseline -> 'PharoStartupSettings').
			(#repository
				-> 'github://rvillemeur/PharoStartupSettings/repository')}).
	(#project2
		->
			{(#name -> 'Argentum').
			(#help -> 'financial and interest calculation made easy').
			(#baseline -> 'Argentum').
			(#repository -> 'github://rvillemeur/argentum/repository')}).
	(#project3
		->
			{(#name -> 'Glorp book').
			(#help -> 'introduction to glorp').
			(#baseline -> 'GlorpBook').
			(#repository -> 'github://rvillemeur/glorpbook/repository')}).
	(#project4
		->
			{(#name -> 'sourdough').
			(#help -> 'sourdough').
			(#baseline -> 'Sourdough').
			(#repository -> 'github://rvillemeur/sourdough/src')}).
	(#project5
		->
			{(#name -> 'Small Clock').
			(#help -> 'an animated clock using morphic').
			(#baseline -> 'SmallClock').
			(#repository -> 'github://rvillemeur/smallclock/src')}).
	(#project6
		->
			{(#name -> 'Game of Life').
			(#help -> 'a simple game of life implementation with Morphic').
			(#baseline -> 'SmallGameOfLife').
			(#repository -> 'github://rvillemeur/SmallGameOfLife/src')}).
	(#project7
		->
			{(#name -> 'Athens Sketch').
			(#help -> 'A collection a Athens sketch drawing sample').
			(#baseline -> 'AthensSketch').
			(#repository -> 'github://rvillemeur/AthensSketch/src')}).}
		asDictionary
]

{ #category : #api }
ProjectSelector >> accept [
self projectSelected do: [ :project | self getProject: (self class projectCollection at: project) asDictionary ].
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

{ #category : #fetching }
ProjectSelector >> fetchProject: aBaseline from: aRepository [
	Metacello new
		baseline: aBaseline;
		repository: aRepository;
		load
]

{ #category : #fetching }
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
	projectSelected := OrderedCollection new.
	^ self
]

{ #category : #initialization }
ProjectSelector >> initializeDialogWindow: aDialog [
	super initializeDialogWindow: aDialog.
	aDialog
		title: self title;
		closeOnBackdropClick: false;
		initialExtent: self width @ self height;
		okAction: [ :presenter | self accept ];
		cancelAction: [ :presenter | self cancel ]
]

{ #category : #initialization }
ProjectSelector >> initializePresenters [
	projects
		keysAndValuesDo: [ :key :project | 
			project whenActivatedDo: [ self selectProject: key ].
			project whenDeactivatedDo: [ self unselectProject: key ] ]
]

{ #category : #initialization }
ProjectSelector >> initializeWidgets [
	projects := Dictionary new.
	self class projectCollection
		keysAndValuesDo: [ :key :value | 
			| model detail |
			detail := value asDictionary.
			model := self newCheckBox
				label: (detail at: #name);
				help: (detail at: #help);
				yourself.
			projects at: key put: model ].
	projectList := (self instantiate: SpListPresenter)
		display: [ :x | x buildWithSpec ];
		items: projects values;
		yourself
]

{ #category : #'instance creation' }
ProjectSelector >> open [
	<script: 'self new openModalWithSpec'>
	
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
	projectSelected add: aProject
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
