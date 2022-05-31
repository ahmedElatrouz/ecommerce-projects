import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Product } from 'src/app/common/product';
import { ProductService } from 'src/app/services/product.service';

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list-grid.component.html',
  styleUrls: ['./product-list.component.css']
})
export class ProductListComponent implements OnInit {

  products: Product[] = [];
  currentCategoryId: number = 1;
  previousCategoryId: number = 1;
  currentCategoryName!: string;
  searchMode: boolean = false;

  pageNumber: number = 1;
  pageSize: number = 5;
  totalElements:number = 0;
  previousKeyword!: string;


  constructor(private productService: ProductService,
              private route: ActivatedRoute) { }
  

  ngOnInit(): void {
    this.route.paramMap.subscribe(() => {
      this.listProducts();
    })
  }

  listProducts(){
    this.searchMode = this.route.snapshot.paramMap.has('keyword');

    if(this.searchMode) {
      this.handleSearchProducts();
    } else {
      this.handleListProducts();
    }
    
  }


  handleSearchProducts() {
    const searchKeyword = this.route.snapshot.paramMap.get('keyword')!;
    
    if (this.previousKeyword != searchKeyword){
      this.pageNumber = 0;
    }

    this.previousKeyword = searchKeyword;
    
    this.productService.searchProductListPaginate(this.pageNumber - 1, this.pageSize, searchKeyword).subscribe(
      this.processResult()
    )
  }

  handleListProducts(){
    const hasCategoryId = this.route.snapshot.paramMap.has('id');
    

    if(hasCategoryId && this.route.snapshot.paramMap != null) {
      this.currentCategoryId = +this.route.snapshot.paramMap.get('id')!;
      this.currentCategoryName = this.route.snapshot.paramMap.get('name')!;
    } else {
      this.currentCategoryId =1;
      this.currentCategoryName = 'Books';
    }
      //if we have a different category id => reset pageNumber to 1
    if (this.previousCategoryId != this.currentCategoryId){
       this.pageNumber = 1;
    }

    this.previousCategoryId = this.currentCategoryId;


    
    this.productService.getProductListPaginate(this.pageNumber - 1,this.pageSize,this.currentCategoryId).subscribe(
      this.processResult()
    )
  }


  processResult() {
    return (data: { _embedded: { products: Product[]; }; page: { number: number; size: number; totalElements: number; }; }) => {
      this.products = data._embedded.products;
      this.pageNumber = data.page.number + 1;
      this.pageSize = data.page.size;
      this.totalElements = data.page.totalElements;
    }  
  }

  updatePageSize(newSize : number) {
    this.pageSize = newSize;
    this.pageNumber = 1;
    this.listProducts();
  }

  addToCart(product: Product) {
      //TODO .. add to cart
  }
}
