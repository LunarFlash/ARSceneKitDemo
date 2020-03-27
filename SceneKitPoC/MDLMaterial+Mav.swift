//
//  MDLMaterial+Mav.swift
//  SceneKitPoC
//
//  Created by Terry Wang on 3/26/20.
//  Copyright © 2020 Terry Wang. All rights reserved.
//

import SceneKit

extension MDLMaterial {
    func setTextureProperties(textures: [MDLMaterialSemantic: String]) -> Void {

        for (key,value) in textures {
            let finalURL = Bundle.main.url(forResource: value, withExtension: "")
            guard let url = finalURL else {
                // fatalError("Failed to find URL for resource \(value).")
                return
            }

            let property = MDLMaterialProperty(name: "Camera.mtl", semantic: key, url: url)
            self.setProperty(property)
        }
    }
}
