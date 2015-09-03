 // Your init script
 //
 // Atom will evaluate this file each time a new window is opened. It is run
 // after packages are loaded/activated and after the previous editor state
 // has been restored.
 //
 // An example hack to log to the console when each text editor is saved.
 //
 // atom.workspace.observeTextEditors (editor) ->
 //   editor.onDidSave ->
 //     console.log "Saved! #{editor.getPath()}"

 function isPlatform(name) {
   return document.body.classList.contains(`platform-${name}`);
 }

 function isLinux() {
   return isPlatform('linux');
 }

 function isMac() {
   return isPlatform('darwin');
 }

 function isWindows() {
   return isPlatform('win32');
 }



atom.commands.add('atom-text-editor', 'mb:run-term', function (event) {
    alert('HERE');
});
