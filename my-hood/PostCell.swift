//
//  PostCell.swift
//  my-hood
//
//  Created by Admin on 08/03/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImg:UIImageView!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var descLbl:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        postImg.layer.cornerRadius = postImg.frame.size.width / 2
        postImg.clipsToBounds = true
    }
    func configureCell(post:Post){
        titleLbl.text = post.title
        descLbl.text = post.postDesc
        postImg.image = DataService.instance.imgForPath(post.imagePath)
        
    }
}
