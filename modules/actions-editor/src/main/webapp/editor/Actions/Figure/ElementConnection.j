/**
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * @author "Esteban Robles Luna <esteban.roblesluna@gmail.com>"
 */
@implementation ElementConnection : Connection 
{
	id _elementName;
}

- (id) initWithSource: (Figure) aSourceFigure target: (Figure) aTargetFigure points: (id) anArrayOfPoints
{ 
	CPLog.debug("[ElementConnection] " + JSON.stringify(anArrayOfPoints));
	self = [super initWithSource: aSourceFigure target: aTargetFigure points: anArrayOfPoints];
	
	[[Actions mode]	createElementConnectionMenu: self];
	
	return self;
}

- (id) elementName
{
	return _elementName;
}

- (void) deleteFromServer
{
	[[self model] deleteFromServer];
}

- (void) deleted
{
   [self removeMyself];
}

- (void) addLazyAutorefreshableCache
{
	var myController = [[ElementAPIWindowController alloc] initWithWindowCibName: "AddLazyAutorefreshableCacheWindow"];
	[myController showWindow: nil];
	[myController elementAPI: [[self model] api]];
}

- (void) addLazyComputedCache
{
	var myController = [[ElementAPIWindowController alloc] initWithWindowCibName: "AddLazyComputedCacheWindow"];
	[myController showWindow: nil];
	[myController elementAPI: [[self model] api]];
}

- (id) elementId
{
	return [[self model] elementId];
}
@end