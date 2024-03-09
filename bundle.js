/*
 * ATTENTION: The "eval" devtool has been used (maybe by default in mode: "development").
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "./src/index.ts":
/*!**********************!*\
  !*** ./src/index.ts ***!
  \**********************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\nconsole.log('hi');\nwindow.ACMEDesignPlugin = {\n    startGame: () => {\n        const model = Neara.getModel();\n        model.getUPgState().setActive(true);\n        const poles = model.getCPoleReport();\n        const targetPole = poles[Math.floor(Math.random() * poles.length)];\n        const target = new Vector3();\n        target.x = targetPole.getPoleReportItem().getLocationX();\n        target.y = targetPole.getPoleReportItem().getLocationY();\n        target.z = targetPole.getPoleReportItem().getGroundZ();\n        const cameraOffset = new Vector3();\n        cameraOffset.x = -100;\n        cameraOffset.y = -100;\n        cameraOffset.z = 50;\n        Neara.editor.perspectiveView.lookAt(target, cameraOffset);\n        Neara.editor.perspectiveView.setScrollFocus(target);\n    },\n    endGame: () => {\n        const model = Neara.getModel();\n        model.getUPgState().setActive(false);\n        Neara.editor.perspectiveView.setScrollFocus(null);\n    },\n};\n// Set the functions from this plugin that will be exposed to run in a Neara project\nNeara.setPermittedPluginFunctions([\n    'ACMEDesignPlugin.startGame',\n    'ACMEDesignPlugin.endGame',\n]);\n\n\n\n//# sourceURL=webpack://plugin/./src/index.ts?");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The require scope
/******/ 	var __webpack_require__ = {};
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/make namespace object */
/******/ 	(() => {
/******/ 		// define __esModule on exports
/******/ 		__webpack_require__.r = (exports) => {
/******/ 			if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 				Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 			}
/******/ 			Object.defineProperty(exports, '__esModule', { value: true });
/******/ 		};
/******/ 	})();
/******/ 	
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module can't be inlined because the eval devtool is used.
/******/ 	var __webpack_exports__ = {};
/******/ 	__webpack_modules__["./src/index.ts"](0, __webpack_exports__, __webpack_require__);
/******/ 	
/******/ })()
;