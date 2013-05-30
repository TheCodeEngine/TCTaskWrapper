TCTaskWrapper
=============

A NSTask Wrapper for Mac OS X

## Install
Add as git Module
```sh
git submodule add git@github.com:TheCodeEngine/TCTaskWrapper.git
git submodule init
```

## Syncron Task
To run a syncron Task
```objective-c
NSError *taskRUnError;
TCTaskWrapper *task = [[TCTaskWrapper alloc] initWithTaskPath:@"/bin/ls" arguments:@[@"l"]];
if ( ![task runTaskSyncronError:&taskRUnError] ) {
    // Task has Error
}
else
{
    // Task Exit
    NSString *outDataString = [task outPutDataToString];
}
```

## License

TCTaskWrapper is is licensed under the [MIT license](http://en.wikipedia.org/wiki/MIT_License). See the LICENSE file in the project root for the full text.
